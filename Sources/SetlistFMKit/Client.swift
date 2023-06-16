
import Foundation

protocol Client {
    func makeRequest(for url: URL) -> URLRequest
    var session: URLSession {get}
    var baseURL: String {get}

}
extension Client {
    
    func fetch<T:Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            print("Endpoint \(endpoint) couldn't cast to URL")
            throw ClientError.endpoint(baseURL+endpoint)
        }
        return try await request(url: url)
    }
    
    func fetch<E:Encodable, D:Decodable>(_ parameters: E, endpoint: String) async throws -> D {
        let url = try createURL(with: parameters, endpoint: endpoint)
        return try await request(url: url)
    }
}

extension Client {
    var session: URLSession { URLSession.shared }
    
    private func createURL<T:Encodable>(with object: T, endpoint: String) throws -> URL {
        
        let endpoint = baseURL + endpoint
        guard var components = URLComponents(string: endpoint) else {
            throw ClientError.endpoint(endpoint)
        }
        let queryParameters = try QueryEncoder().encode(object)
        
        components.queryItems = queryParameters
            .filter { $0.value != "" }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        if let url = components.url {
            return url
        } else {
            throw ClientError.endpoint(endpoint)
        }
        
    }

    private func request<T: Decodable>(url: URL) async throws -> T {
        print("Requesting \(url.absoluteString)")
        
        let request = makeRequest(for: url)

        
        let (data, response) = try await session.data(for: request)
        
        guard let requestResponse = response as? HTTPURLResponse,
              (200 ..< 300) ~= requestResponse.statusCode else {
            printJSON(data)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            print(response)
            throw ClientError.statusCode(statusCode ?? -1, url.absoluteString)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ClientError.decode(T.self)
        }
    }
    
    func printJSON(_ data: Data) {
        if let nsString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            Swift.print(nsString)
        } else {
            print("Data doesn't represent a valid JSON structure.")
        }
    }
}
struct QueryEncoder {
    func encode<E: Encodable>(_ object: E) throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(object)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dictionary = jsonObject as? [String: Any] else {
            throw ClientError.encode(E.self)
        }
        return dictionary.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
    }
}

enum ClientError: Swift.Error{
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
}


