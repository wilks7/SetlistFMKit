//
//  File.swift
//  
//
//  Created by Michael on 6/14/23.
//

import Foundation

public extension SetlistFMClient {
    
    private var artistEndpoint: String { "artist/" }
    
    /// Returns an artist for a given Musicbrainz MBID
    /// - Parameter mbid: A Musicbrainz MBID, e.g. 0bfba3d3-6a04-4779-bb0a-df07df5b0558
    
    func getArtist(mbid: String) async throws -> FMArtist {
        let endpoint = artistEndpoint + mbid
        return try await self.fetch(endpoint: endpoint)
    }
    
    /// Get a list of an artist's setlists
    /// - Parameter mbid: The Musicbrainz MBID of the artist
    /// - Parameter pageNumber: The number of the result page. Default value is 1.
    /// - Parameter completion: A callback that returns the requested list of setlists as an `FMSetlistsResult`

    func getArtistSetlists(mbid: String, pageNumber: Int = 1) async throws -> FMSetlistsResult {
        let endpoint = "\(artistEndpoint)\(mbid)/setlists?p=\(pageNumber)"

        return try await self.fetch(endpoint: endpoint)

    }
}
