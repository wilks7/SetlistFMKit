
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Search Setlists Endpoints for the SetlistFM API.
*/

public extension SetlistFMClient {
    /// Searches for setlists given a wide range of parameters.
    ///
    /// - Parameters:
    ///   - artistMbid: A MusicBrainz ID to search by, or `nil` for no specific ID.
    ///   - artistName: An artist's name to search by, or `nil` for no specific artist.
    ///   - artistTmid: A Ticketmaster ID to search by, or `nil` for no specific ID.
    ///   - cityId: A city ID to search by, or `nil` for no specific city.
    ///   - cityName: A city name to search by, or `nil` for no specific city.
    ///   - countryCode: A country code to search by, or `nil` for no specific country.
    ///   - date: A date to search by, or `nil` for no specific date.
    ///   - lastFM: A LastFM parameter to search by, or `nil` for no specific LastFM parameter.
    ///   - lastUpdated: A last updated parameter to search by, or `nil` for no specific update time.
    ///   - pageNumber: The number of the result page. Default value is 1.
    ///   - state: A state to search by, or `nil` for no specific state.
    ///   - stateCode: A state code to search by, or `nil` for no specific state code.
    ///   - tourName: A tour name to search by, or `nil` for no specific tour.
    ///   - venueId: A venue ID to search by, or `nil` for no specific venue.
    ///   - venueName: A venue name to search by, or `nil` for no specific venue.
    ///   - year: A year to search by, or `nil` for no specific year.
    /// - Returns: An `FMSetlistsResult` instance representing the results of the setlist search.

    func searchSetlists(artistMbid: String? = nil,
                        artistName: String? = nil,
                        artistTmid: Int? = nil,
                        cityId: String? = nil,
                        cityName: String? = nil,
                        countryCode: String? = nil,
                        date: String? = nil,
                        lastFM: String? = nil,
                        lastUpdated: String? = nil,
                        pageNumber: Int = 1,
                        state: String? = nil,
                        stateCode: String? = nil,
                        tourName: String? = nil,
                        venueId: String? = nil,
                        venueName: String? = nil,
                        year: String? = nil
    ) async throws -> FMSetlistsResult {
        logger.debug("Searching for Setlist")

        let endpoint = "search/setlists"
        let requestModel = SearchSetlists(
            artistMbid: artistMbid ?? "",
            artistName: artistName ?? "",
            artistTmid: artistTmid.flatMap { "\($0)" } ?? "",
            cityId: cityId ?? "",
            cityName: cityName ?? "",
            countryCode: countryCode ?? "",
            date: date ?? "",
            lastFM: lastFM ?? "",
            lastUpdated: lastUpdated ?? "",
            p: pageNumber,
            state: state ?? "",
            stateCode: stateCode ?? "",
            tourName: tourName ?? "",
            venueId: venueId ?? "",
            venueName: venueName ?? "",
            year: year ?? ""
        )
        
        return try await self.fetch(requestModel, endpoint: endpoint)
    }

}


struct SearchSetlists: FMRequest {
    /// The artist's Musicbrainz Identifier (mbid)
    let artistMbid: String
    
    /// The artist's name
    let artistName: String
    
    /// The artist's Ticketmaster Identifier (tmid)
    let artistTmid: String
    
    /// The city's geoId
    let cityId: String
    
    /// The name of the city
    let cityName: String
    
    /// The country code
    let countryCode: String
    
    /// The date of the event (format dd-MM-yyyy)
    let date: String
    
    /// The event's Last.fm Event ID (deprecated)
    let lastFM: String
    
    /// The date and time (UTC) when this setlist was last updated (format yyyyMMddHHmmss) -
    /// either edited or reverted. Search will return setlists that were updated on or after this date.
    let lastUpdated: String
    
    /// The number of the result page
    let p: Int
    
    /// The state
    let state: String
    
    /// The state code
    let stateCode: String
    
    /// The name of the tour
    let tourName: String
    
    /// The venue id
    let venueId: String
    
    /// The name of the venue
    let venueName: String
    
    /// The year of the event
    let year: String
    
    var endpoint: String {
        return "search/setlists"
    }
    
    var queryParameters: [String : String]? {
        return [
            "artistMbid": artistMbid,
            "artistName": artistName,
            "artistTmid": artistTmid,
            "cityId": cityId,
            "cityName": cityName,
            "countryCode": countryCode,
            "date": date,
            "lastFM": lastFM,
            "lastUpdated": lastUpdated,
            "p": "\(p)",
            "state": state,
            "stateCode": stateCode,
            "tourName": tourName,
            "venueId": venueId,
            "venueName": venueName,
            "year": year
        ]
    }
}


/// The response model for a Setlist.fm API request containing multiple setlists
public struct FMSetlistsResult: FMResult {
    /// Result list of setlists
    public let setlist: [FMSetlist]
    
    /// The total amount of items matching the query
    public let total: Int
    
    /// The current page. Starts at 1
    public let page: Int
    
    /// The amount of items you get per page
    public let itemsPerPage: Int
}



