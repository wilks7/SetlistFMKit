/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A client to handle network communications with the MusicBrainz API.
*/

import Foundation

/// This class prepares and sends requests to the MusicBrainz API, and handles responses.
public class MusicBrainzClient: Client {

    /// The base URL for the MusicBrainz API.
    public let baseURL: String = "https://musicbrainz.org/ws/2/"
    
    /// The shared URL session object.
    public let session = URLSession.shared
    
    /// The application name to be used in requests' User-Agent header.
    public let appName: String
    
    /// The application version to be used in requests' User-Agent header.
    public let version: String
    
    /// The contact information to be used in requests' User-Agent header.
    public let contact: String

    /// Creates a new `MusicBrainzClient`.
    ///
    /// - Parameters:
    ///   - appName: The application name to be used in requests' User-Agent header.
    ///   - version: The application version to be used in requests' User-Agent header.
    ///   - contact: The contact information to be used in requests' User-Agent header.
    public init(appName: String, version: String, contact: String) {
        self.appName = appName
        self.version = version
        self.contact = contact
    }

    /// Prepares a new `URLRequest` for a given URL.
    ///
    /// This function prepares the HTTP method, headers, and body for the request.
    ///
    /// - Parameter url: The `URL` to prepare a request for.
    /// - Returns: A `URLRequest` prepared for the given `URL`.
    func makeRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(appName)/\(version) ( \(contact) )", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}

