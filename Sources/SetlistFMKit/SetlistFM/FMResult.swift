
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A utility type for SetlistFM API results.
*/

/// A type that is returned from SetlistFM API query.
public protocol FMResult: Decodable, Equatable {
    
    /// The total amount of items matching the query
    var total: Int {get}
    
    /// The current page. Starts at 1.
    var page: Int {get}
    
    /// The amount of items you get per page
    var itemsPerPage: Int {get}
}


protocol FMRequest: Encodable {
    var p: Int { get }
}

public enum SortType: String {
    /// Default sorting type
    case sortName
    
    /// Specifies sorting of the results by relevance
    case relevance
}
