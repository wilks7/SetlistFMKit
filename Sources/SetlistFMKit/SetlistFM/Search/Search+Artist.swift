
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Search Artist Endpoints for the SetlistFM API.
*/

public extension SetlistFMClient {
    
    /// Searches for artists given a set of parameters.
    ///
    /// - Parameters:
    ///   - mbid: A MusicBrainz ID to search by, or `nil` for no specific ID.
    ///   - name: A name to search by, or `nil` for no specific name.
    ///   - tmid: A Ticketmaster ID to search by, or `nil` for no specific ID.
    ///   - pageNumber: The number of the result page. Default value is 1.
    ///   - sortType: A `SortType` value that determines the order of the results. Default value is `.relevance`.
    /// - Returns: An `ArtistResults` instance representing the results of the artist search.
    func searchArtists(mbid: String? = nil,
                       name: String? = nil,
                       tmid: Int? = nil,
                       pageNumber: Int = 1,
                       sortedBy sortType: SortType = .relevance
    ) async throws -> ArtistResults {
        let endpoint = "search/artists"
        
        let requestModel = SearchArtist(
            artistMbid: mbid ?? "",
            artistName: name ?? "",
            artistTmid: tmid.flatMap { "\($0)" } ?? "",
            p: pageNumber,
            sort: sortType.rawValue
        )
        
        return try await self.fetch(requestModel, endpoint: endpoint)
    }

}


/// The request model for requests to the /search/artists endpoint
struct SearchArtist: FMRequest {
    /// The artist's Musicbrainz Identifier (mbid)
    let artistMbid: String
    
    /// The artist's name
    let artistName: String
    
    /// The artist's Ticketmaster Identifier (tmid)
    let artistTmid: String
    
    /// The number of the result page you'd like to have
    let p: Int
    
    /// The sort of the result, either sortName (default) or relevance
    let sort: String

}

/// The response model for a Setlist.fm API request containing multiple artists
public struct ArtistResults: FMResult {
    // Result list of artists
    public let artist: [FMArtist]
    
    /// The total amount of items matching the query
    public let total: Int
    
    /// The current page. Starts at 1.
    public let page: Int
    
    /// The amount of items you get per page
    public let itemsPerPage: Int
}
