
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Song fetched from the SetlistFM API.
*/


/// The model for a Song object from the Setlist.fm API
public struct FMSong: Codable, Equatable {
    
    public let name: String?
    
    /// A different `FMArtist` than the performing one that joined the stage for this song
    public let with: FMArtist?
    
    /// The original `FMArtist` of this song, if different to the performing artist
    public let cover: FMArtist?
    
    /// Special incidents or additional information about the way the song was performed at this specific concert.
    /// See the [setlist.fm guidelines](https://www.setlist.fm/guidelines) for a complete list of allowed content.
    public let info: String?
    
    /// The song came from tape rather than being performed live.
    /// See the [tape section of the guidelines](https://www.setlist.fm/guidelines#tape-songs) for valid usage.
    public let tape: Bool?
}
