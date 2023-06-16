
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Set fetched from the SetlistFM API.
*/

/// The model for a Set object from the Setlist.fm API
public struct FMSet: Decodable, Equatable {
    /// The description/name of the set. E.g. "Acoustic set" or "Paul McCartney solo"
    public let name: String?
    
    /// If the set is an encore, this is the number of the encore,
    /// starting with 1 for the first encore, 2 for the second and so on
    public let encore: Int?
    
    /// This set's songs
    public let song: [FMSong]
}
