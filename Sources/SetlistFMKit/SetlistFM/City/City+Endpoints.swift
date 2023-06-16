
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
City Endpoints for the SetlistFM API.
*/

public extension SetlistFMClient {
    
    /// Fetches a city's information given its GeoId.
    ///
    /// - Parameter geoId: A GeoId representing a specific city.
    /// - Returns: An `FMCity` instance representing the details of the city associated with the provided GeoId.

    func getCity(geoId: String) async throws -> FMCity {
        let endpoint = "city/" + geoId
        return try await self.fetch(endpoint: endpoint)
    }
}
