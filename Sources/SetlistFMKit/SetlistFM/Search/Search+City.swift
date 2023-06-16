
public extension SetlistFMClient {
    
    /// Search for a city. **You must specify one parameter other than** `pageNumber` **for the call to succeed**
    /// - Parameter country: The city's country. Specify the country code rather than the full name of the country, otherwise a 404 will occur.
    /// - Parameter name: Name of the city
    /// - Parameter pageNumber: The number of the result page you'd like to have
    /// - Parameter state: State the city lies in. Unlike `country`, you can specify the full name of the state here
    /// - Parameter stateCode: State code the city lies in
    /// - Parameter complete: A callback that returns the requested list of cities as an `FMCitiesResult`
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
    /// - Parameter completion: A callback that returns the requested list of countries as an `FMCountriesResult`
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

