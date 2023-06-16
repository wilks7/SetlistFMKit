
import Foundation
import OSLog

private let logger = Logger(subsystem: "Client", category: "SetlistFMClient")

public class SetlistFMClient {
    private let baseURL: String = "https://api.setlist.fm/rest/1.0/"
    private let session = URLSession.shared
    private let apiKey: String
    private let language: SupportedLanguage = .english
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func print(_ items: Any...) {
        Swift.print("[SetlistFMCLient]", items)
    }
    
    func fetch<T:Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            print("Endpoint \(endpoint) couldn't cast to URL")
            throw Error.endpoint(baseURL+endpoint)
        }
        return try await request(url: url)
    }
    
    func fetch<E:Encodable, D:Decodable>(_ parameters: E, endpoint: String) async throws -> D {
        let url = try createURL(with: parameters, endpoint: endpoint)
        return try await request(url: url)
    }
    
    func search<E:Encodable, D:Decodable>(_ parameters: E, endpoint: String) async throws -> D {
        let url = try createURL(with: parameters, endpoint: endpoint)
        return try await request(url: url)
    }
    
    private func createURL<T:Encodable>(with object: T, endpoint: String) throws -> URL {
        
        let endpoint = baseURL + endpoint
        guard var components = URLComponents(string: endpoint) else {
            logger.log("Endpoint \(endpoint) couldn't cast to URL")
            throw Error.endpoint(endpoint)
        }
        let queryParameters = try QueryEncoder().encode(object)
        
        components.queryItems = queryParameters
            .filter { $0.value != "" }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        if let url = components.url {
            return url
        } else {
            throw Error.endpoint(endpoint)
        }
        
    }
    

    private func request<T: Decodable>(url: URL) async throws -> T {
        print("Requesting \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(language.rawValue, forHTTPHeaderField: "Accept-Language")
        
        let (data, response) = try await session.data(for: request)
        
        guard let requestResponse = response as? HTTPURLResponse,
              (200 ..< 300) ~= requestResponse.statusCode else {
            printJSON(data)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            print(response)
            throw Error.statusCode(statusCode ?? -1, url.absoluteString)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw Error.decode(T.self)
        }
    }
    
    private func printJSON(_ data: Data) {
        if let nsString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            Swift.print(nsString)
        } else {
            print("Data doesn't represent a valid JSON structure.")
        }
    }
    
    
    struct QueryEncoder {
        func encode<E: Encodable>(_ object: E) throws -> [URLQueryItem] {
            let data = try JSONEncoder().encode(object)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary = jsonObject as? [String: Any] else {
                throw Error.encode(E.self)
            }
            return dictionary.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        }
    }


}

public extension SetlistFMClient {
    
    enum SortType: String {
        /// Default sorting type
        case sortName
        
        /// Specifies sorting of the results by relevance
        case relevance
    }
    
    enum Error: Swift.Error, LocalizedError{
        case encode(Encodable.Type)
        case decode(Decodable.Type)
        case statusCode(Int, String)
        case message(String)
        case endpoint(String)
        
        var message: String {
            switch self {
            case .decode(let decodable):
                let object = String(describing: decodable)
                return object + "could not be decoded"
            case .statusCode(let int, let string):
                return int.description + ": " + string
            case .message(let string):
                return string
            case .endpoint(let string):
                return string
            case .encode(let encodeable):
                return String(describing: encodeable)
            }
        }
        
        var localizedDescription: String {
            switch self {
            case .decode(let decodable):
                return String(describing: decodable)
            case .statusCode(let int, let string):
                return int.description + ": " + string
            case .message(let string):
                return string
            case .endpoint(let string):
                return string
            case .encode(let encodeable):
                return String(describing: encodeable)
            }
        }
    }
    
    enum SupportedLanguage: String {
        case english    = "en"
        case spanish    = "es"
        case french     = "fr"
        case german     = "de"
        case portuguese = "pt"
        case turkish    = "tr"
        case italian    = "it"
        case polish     = "pl"
    }
}
