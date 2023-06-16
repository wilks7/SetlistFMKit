
import Foundation
import os.log
import OSLog

protocol Client {
    func makeRequest(for url: URL) -> URLRequest
    var session: URLSession {get}
    var baseURL: String {get}
    var networkLogger: Logger { get }

}
extension Client {
    
    var logger: Logger {
        Logger(subsystem: "com.example.MyApp", category: "Networking")
    }
    
    func fetch<T:Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            logger.error("Endpoint \(endpoint) couldn't cast to URL")
//            print("Endpoint \(endpoint) couldn't cast to URL")
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
            logger.error("URL Components \(endpoint) couldn't cast to URL")
            throw ClientError.endpoint(endpoint)
        }
        
        let queryParameters: [URLQueryItem]
        do {
            queryParameters = try QueryEncoder().encode(object)
        } catch {
            logger.error("QueryEncoder couldn't encode parameters for \(String(describing: T.self))")
            throw error

        }
        
        components.queryItems = queryParameters
            .filter { $0.value != "" }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        if let url = components.url {
            return url
        } else {
            logger.error("URL Components \(endpoint) couldn't cast to URL")
            throw ClientError.endpoint(endpoint)
        }
        
    }

    private func request<T: Decodable>(url: URL) async throws -> T {
        logger.debug("Requesting \(url.absoluteString)")

        let request = makeRequest(for: url)
        
        let (data, response) = try await session.data(for: request)
        
        guard let requestResponse = response as? HTTPURLResponse,
              (200 ..< 300) ~= requestResponse.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            logger.error("Status Code: \(statusCode ?? -1) for \(url.absoluteString)")
            Swift.print( jsonString(data) )
            throw ClientError.statusCode(statusCode ?? -1, url.absoluteString)
        }
        logger.debug("Received Response for \(String(describing: T.self))")

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            logger.error("Decode error for \(String(describing: T.self))")
            Swift.print( jsonString(data) )
            throw ClientError.decode(T.self)
        }
    }
    
    private func jsonString(_ data: Data) -> NSString {
        if let nsString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            return nsString
        } else {
            return "Data doesn't represent a valid JSON structure."
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


