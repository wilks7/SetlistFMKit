
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Venue fetched from the SetlistFM API.
*/

/// The model for a Venue object from the Setlist.fm API
public struct FMVenue: Codable, Identifiable, Equatable {
    /// The city in which the venue is located
    public let city: FMCity
    
    /// The attribution url
    public let url: String?
    
    /// Unique identifier
    public let id: String
    
    /// The name of the venue, usually without city and country. E.g. "Madison Square Garden" or "Royal Albert Hall"
    public let name: String
}

/// The model for a Tour object from the Setlist.fm API
public struct FMTour: Codable, Equatable {
    /// The name of the tour.
    public let name: String
}

extension FMVenue: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
