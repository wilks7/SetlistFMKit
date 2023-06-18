/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
 A client to handle network communications with the SetlistFM API.
*/


import Foundation
import OSLog
import DrillURL

/// This class prepares and sends requests to the SetlistFM API, and handles responses.
public class SetlistFMClient: DrillURL.DrillClient {

    /// The base URL for the SetlistFM API.
    public let baseURL: String = "https://api.setlist.fm/rest/1.0/"

    /// The API key to use for authentication.
    private let apiKey: String

    /// The language to request data in. Default is English.
    private let language: SupportedLanguage = .english
    
    /// The logger used by Client protocol to log networking.
    public let networkLogger: Logger
    
    /// The logger used by SetlistFM to log results.
    public let logger: Logger

    /// Creates a new `SetlistFMClient`.
    ///
    /// - Parameter apiKey: The API key to use for authentication.
    public init(apiKey: String, appName: String, orginization: String) {
        self.apiKey = apiKey
        self.networkLogger = Logger(subsystem: "app.\(orginization).\(appName)", category: "Networking")
        self.logger = Logger(subsystem: "app.\(orginization).\(appName)", category: "SetlistFM")
    }

    /// Prepares a new `URLRequest` for a given URL.
    ///
    /// This function prepares the HTTP method, headers, and body for the request.
    ///
    /// - Parameter url: The `URL` to prepare a request for.
    /// - Returns: A `URLRequest` prepared for the given `URL`.
    public func makeRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(language.rawValue, forHTTPHeaderField: "Accept-Language")
        
        return request
    }
}

public extension SetlistFMClient {
    

    
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
