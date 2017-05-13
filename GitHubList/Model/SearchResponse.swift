//
//  SearchResponse.swift
//  GitHubList
//
//  Created by Andrea Stevanato on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchResponse: Mappable {
    
    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [User]?
    
    // MARK: JSON
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["item"]
    }
    
}
