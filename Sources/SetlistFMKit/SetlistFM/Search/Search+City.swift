
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Search City Endpoints for the SetlistFM API.
*/

public extension SetlistFMClient {
    
    /// Searches for cities given a set of parameters.
    ///
    /// - Parameters:
    ///   - country: The name of the country to search for cities in, or `nil` for no specific country.
    ///   - name: The name of the city to search for, or `nil` for no specific city.
    ///   - pageNumber: The number of the result page. Default value is 1.
    ///   - state: The name of the state to search for cities in, or `nil` for no specific state.
    ///   - stateCode: The state code to search for cities in, or `nil` for no specific state code.
    /// - Returns: A `CitiesResults` instance representing the results of the city search.

    func searchCities(country: String? = nil,
                      name: String? = nil,
                      pageNumber: Int = 1,
                      state: String? = nil,
                      stateCode: String? = nil) async throws -> CitiesResults {
        let endpoint = "search/cities"
        let requestModel = SearchCities(
            country: country ?? "",
            name: name ?? "",
            p: pageNumber,
            state: state ?? "",
            stateCode: stateCode ?? ""
        )
        
        return try await self.fetch(requestModel, endpoint: endpoint)
    }
    
    
    /// Get a complete list of all supported countries
    ///
    /// - Returns: A `FMCountriesResult` instance representing the results of the country search.
    func searchCountries() async throws -> FMCountriesResult {
        return try await self.fetch(endpoint: "search/countries")
    }
    
}

/// The request model for requests to the /search/cities endpoint
struct SearchCities: FMRequest {
    /// The city's country
    let country: String
    
    /// Name of the city
    let name: String
    
    /// the number of the result page you'd like to have
    let p: Int
    
    /// State the city lies in
    let state: String
    
    /// State code the city lies in
    let stateCode: String
    

}


/// The model for a Country object from the Setlist.fm API
public struct FMCountriesResult: FMResult {
    /// Result list of countries
    public let country: [FMCountry]
    
    /// The total amount of items matching the query
    public let total: Int
    
    /// The current page, starts at 1
    public let page: Int
    
    /// The amount of items you get per page
    public let itemsPerPage: Int
}



/// The model for a Setlist.fm API request containing multiple cities
public struct CitiesResults: FMResult {
    /// Result list of cities
    public let cities: [FMCity]
    
    /// The total amount of items matching the query
    public let total: Int
    
    /// The current page. starts at 1
    public let page: Int
    
    /// The amount of items you get per page
    public let itemsPerPage: Int
}

