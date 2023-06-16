//
//  File.swift
//  
//
//  Created by Michael on 6/14/23.
//

import Foundation

public extension SetlistFMClient {
    /// Get a city by its unique geoId
    /// - Parameter geoId: The city's geoId
    /// - Parameter completion: A callback that returns the requested city as an `FMCity`
    func getCity(geoId: String) async throws -> FMCity {
        let endpoint = "city/" + geoId
        return try await self.fetch(endpoint: endpoint)
    }
}
