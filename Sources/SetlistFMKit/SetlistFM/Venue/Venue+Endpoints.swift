
public extension SetlistFMClient {
    
    private var venueEndpoint: String { "venue/" }

    
    /// Get a venue by its unique id
    /// - Parameter venueId: The venue's id
    /// - Parameter completion: A callback that returns the requested venue as an `FMVenue`
    func getVenue(venueId: String) async throws -> FMVenue {
        let endpoint = venueEndpoint + venueId
        return try await self.fetch(endpoint: endpoint)
    }

    
    /// Get a venue by its unique id
    /// - Parameter venueId: The venue's id
    /// - Parameter pageNumber: The number of the result page
    /// - Parameter completion: A callback that returns the requested venue's setlists as an `FMSetlistsResult`
    func getVenueSetlists(venueId: String, pageNumber: Int = 1) async throws -> FMSetlistsResult {
        let endpoint = "\(venueEndpoint)\(venueId)?p=\(pageNumber)/setlists"
        return try await self.fetch(endpoint: endpoint)
    }
}
