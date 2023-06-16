//
//  File.swift
//  
//
//  Created by Michael on 6/14/23.
//

import Foundation

public extension SetlistFMClient {
    /// Search for setlists. **You must specify one parameter other than** `pageNumber` **for the call to succeed**
    /// - Parameter artistMbid: The artist's Musicbrainz Identifier (mbid)
    /// - Parameter artistName: The artist's name
    /// - Parameter artistTmid: The artist's Ticketmaster Identifier (tmid)
    /// - Parameter cityId: The city's geoId
    /// - Parameter cityName: The name of the city
    /// - Parameter countryCode: The country code
    /// - Parameter date: The date of the event (format dd-MM-yyyy)
    /// - Parameter lastFM: The event's Last.fm Event ID (deprecated)
    /// - Parameter lastUpdated: The date and time (UTC) when this setlist was last updated (format yyyyMMddHHmmss) -
    /// either edited or reverted. Search will return setlists that were updated on or after this date
    /// - Parameter pageNumber: The number of the result page
    /// - Parameter state: The state
    /// - Parameter stateCode: The state code
    /// - Parameter tourName: The name of the tour
    /// - Parameter venueId: The venue id
    /// - Parameter venueName: The name of the venue
    /// - Parameter year: The year of the event
    /// - Parameter completion: A callback that returns the requested list of setlists as an `FMSetlistsResult`
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
        
        return try await self.search(requestModel, endpoint: endpoint)
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



