//
//  File.swift
//  
//
//  Created by Michael on 6/14/23.
//

import Foundation

public protocol FMResult: Decodable, Equatable {
//    associatedtype Results: Decodable
    
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
