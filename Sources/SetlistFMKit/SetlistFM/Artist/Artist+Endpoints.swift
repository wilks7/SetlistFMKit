
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Artist Endpoints for the SetlistFM API.
*/

public extension SetlistFMClient {
    
    fileprivate var kEndpoint: String { "artist/" }
    
    /// Fetches an artist for a given Musicbrainz MBID
    ///
    /// - Parameter mbid: A Musicbrainz MBID, e.g. 0bfba3d3-6a04-4779-bb0a-df07df5b0558
    /// - Returns: A `FMArtist` instance representing the artist associated with the provided MBID.
    func getArtist(mbid: String) async throws -> FMArtist {
        let endpoint = kEndpoint + mbid
        return try await self.fetch(endpoint: endpoint)
    }
    
    /// Fetches a list of an artist's setlists
    ///
    /// - Parameter mbid: The MusicBrainz MBID of the artist.
    /// - Parameter pageNumber: The number of the result page. Default value is 1.
    /// - Returns: A `FMSetlistsResult` instance, which encapsulates the setlists associated with the provided artist's MBID.
    func getArtistSetlists(mbid: String, pageNumber: Int = 1) async throws -> FMSetlistsResult {
        let endpoint = "\(kEndpoint)\(mbid)/setlists?p=\(pageNumber)"
        return try await self.fetch(endpoint: endpoint)
    }
}
