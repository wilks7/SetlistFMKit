
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Search Venues Endpoints for the SetlistFM API.
*/

public extension SetlistFMClient {
    
    /// Searches for venues given a set of parameters.
    ///
    /// - Parameters:
    ///   - cityId: A city ID to search by, or `nil` for no specific city.
    ///   - cityName: A city name to search by, or `nil` for no specific city.
    ///   - country: A country name to search by, or `nil` for no specific country.
    ///   - name: A venue name to search by, or `nil` for no specific venue.
    ///   - pageNumber: The number of the result page. Default value is 1.
    ///   - state: A state to search by, or `nil` for no specific state.
    ///   - stateCode: A state code to search by, or `nil` for no specific state code.
    /// - Returns: A `VenueResults` instance representing the results of the venue search.
    /// 
    func searchVenues(cityId: String? = nil,
                      cityName: String? = nil,
                      country: String? = nil,
                      name: String? = nil,
                      pageNumber: Int = 1,
                      state: String? = nil,
                      stateCode: String? = nil) async throws -> VenueResults {
        logger.debug("Searching for Venue")

        let endpoint = "search/venues"
        let requestModel = SearchVenue(
            cityId: cityId ?? "",
            cityName: cityName ?? "",
            country: country ?? "",
            name: name ?? "",
            p: pageNumber,
            state: state ?? "",
            stateCode: stateCode ?? ""
        )
        
        return try await self.fetch(requestModel, endpoint: endpoint)
    }
}


/// The request model for requests to the /search/venues endpoint
struct SearchVenue: FMRequest {
    /// The city's geoId
    let cityId: String
    
    /// Name of the city where the venue is located
    let cityName: String
    
    /// The city's country
    let country: String
    
    /// Name of the venue
    let name: String
    
    /// The number of the result page you'd like to have
    let p: Int
    
    /// The city's state
    let state: String
    
    /// The city's state code
    let stateCode: String

}

/// The response model for a Setlist.fm API request containing multiple venues
public struct VenueResults: FMResult {
    // Result list of venue
    public let venue: [FMVenue]
    
    /// The total amount of items matching the query
    public let total: Int
    
    /// The current page. Starts at 1.
    public let page: Int
    
    /// The amount of items you get per page
    public let itemsPerPage: Int
}
