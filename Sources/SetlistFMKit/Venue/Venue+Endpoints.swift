/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Venue Endpoints for the SetlistFM API.
*/
public extension SetlistFMClient {
    
    private var venueEndpoint: String { "venue/" }

    
    /// Get a venue by its unique id
    /// - Parameter venueId: The venue's id
    /// - Returns Requested venue as an `FMVenue`
    func getVenue(venueId: String) async throws -> FMVenue {
        let endpoint = venueEndpoint + venueId
        return try await self.fetch(endpoint: endpoint)
    }

    
    /// Get a venue by its unique id
    /// - Parameter venueId: The venue's id
    /// - Parameter pageNumber: The number of the result page
    /// - Returns  Requested venue's setlists as an `FMSetlistsResult`
    func getVenueSetlists(venueId: String, pageNumber: Int = 1) async throws -> FMSetlistsResult {
        let endpoint = "\(venueEndpoint)\(venueId)?p=\(pageNumber)/setlists"
        return try await self.fetch(endpoint: endpoint)
    }
}
