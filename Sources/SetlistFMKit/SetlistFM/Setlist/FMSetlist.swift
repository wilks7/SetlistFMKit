
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Setlist fetched from the SetlistFM API.
*/

import Foundation

/// The model for a Setlist object from the Setlist.fm API
public struct FMSetlist: Decodable {
    
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
   @DateFormatted<FMSetlistDateStrategy> var eventDate: Date
    
    /// Date, time and time zone of the last update to this setlist in the format "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    public let lastUpdated: String?
}

/// The model for the upper-level `sets` JSON object, which just holds an array of `FMSet`
public struct FMSets: Decodable, Equatable {
    /// The list of sets
    public let set: [FMSet]
}


struct FMSetlistDateStrategy: DateValueStrategy {

    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    static func decode(_ value: String) throws -> Date {
        if let date = formatter.date(from: value) {
            return date
        } else {
            throw DateStrategyError.decode
        }
    }
    
    static func encode(_ date: Date) -> String {
        formatter.string(from: date)
    }
}
