


/// The model for a Setlist object from the Setlist.fm API
public struct FMSetlist: Decodable, Equatable {
    
    public let artist: FMArtist?
    
    public let venue: FMVenue?
    
    public let tour: FMTour?
    
    /// All sets of this setlist
    public let sets: FMSets?
    
    /// Additional information on the concert -
    /// see the [setlist.fm guidelines](https://www.setlist.fm/guidelines) for a complete list of allowed content
    public let info: String?
    
    /// The attribution url to which you have to link to wherever you use data from this setlist in your application
    public let url: String?
    
    /// Unique identifier
    public let id: String
    
    /// Unique identifier of the version
    public let versionId: String?
    
    /// The id this event has on [last.fm](http://last.fm/) (deprecated)
    public let lastFMEventId: Int?
    
    /// Date of the concert in the format "dd-MM-yyyy"
    public let eventDate: String?
    
    /// Date, time and time zone of the last update to this setlist in the format "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    public let lastUpdated: String?
}

/// The model for the upper-level `sets` JSON object, which just holds an array of `FMSet`
public struct FMSets: Decodable, Equatable {
    /// The list of sets
    public let set: [FMSet]
}

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

/// The model for a Song object from the Setlist.fm API
public struct FMSong: Decodable, Equatable {
    
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



