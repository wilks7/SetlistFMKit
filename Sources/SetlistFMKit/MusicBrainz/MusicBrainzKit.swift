// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class MusicBrainzClient {
    public let baseURL: String = "https://musicbrainz.org/ws/2/"
    public let session = URLSession.shared
    public let appName: String
    public let version: String
    public let contact: String
    
    public init(appName: String, version: String, contact: String) {
        self.appName = appName
        self.version = version
        self.contact = contact
    }
    
    public func urlRequest(endpoint: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + endpoint) else {
            print(baseURL + endpoint)
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(appName)/\(version) ( \(contact) )", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    public func request<T: Decodable>(endpoint: String) async throws -> T {
        var request = try urlRequest(endpoint: endpoint)
        
        let (data, response) = try await session.data(for: request)
        
        guard let requestResponse = response as? HTTPURLResponse,
              (200 ..< 300) ~= requestResponse.statusCode else {
            printJSON(data)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            print(response)
            throw Error.statusCode(statusCode ?? -1, request.url?.absoluteString ?? endpoint)
        }
        printJSON(data)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw Error.decode(T.self)
        }
    }
    
    public func printJSON(_ data: Data) {
        if let nsString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            Swift.print(nsString)
        } else {
            print("Data doesn't represent a valid JSON structure.")
        }
    }
    
    public enum Error: Swift.Error, LocalizedError{
        case encode(Encodable.Type)
        case decode(Decodable.Type)
        case statusCode(Int, String)
        case message(String)
        case endpoint(String)
    }
}

public extension MusicBrainzClient {
    
    func search(artist: String) async throws -> [MBArtist] {
        let escapedString = artist.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? artist
        let endpoint = "artist?query=artist:\(escapedString)&fmt=json"
        let result:MBArtistResults = try await request(endpoint: endpoint)
        return result.artists

    }
    
}

public struct MBArtistResults: Decodable {
    public let artists: [MBArtist]
}
