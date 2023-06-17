/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An Artist fetched from the SetlistFM API.
*/


/// The model for an Artist object from the Setlist.fm API
public struct FMArtist: Codable, Equatable {
    /// Unique Musicbrainz Identifier (MBID), e.g. "b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d"
    public let mbid: String
    
    /// The artist's name, e.g. "The Beatles"
    public let name: String
    
//    /// Unique Ticket Master Identifier (TMID), e.g. 735610
//    public let tmid: Int?
    
    /// The artist's sort name, e.g. "Beatles, The" or "Springsteen, Bruce"
    public var sortName: String = ""
    
    /// Disambiguation to distinguish between artists with same names
    public var disambiguation: String = ""
    
    /// The attribution url
    public var url: String = ""
}

import Foundation
public extension FMArtist {
    static var Phish: FMArtist {
        let json = """
        {
          "mbid": "e01646f2-2a04-450d-8bf2-0d993082e058",
          "name": "Phish",
          "sortName": "Phish",
          "disambiguation": "",
          "url": "https://www.setlist.fm/setlists/phish-13d6ad51.html"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        return try! decoder.decode(FMArtist.self, from: json)
    }
}
