//
//  User.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    
    var identifier: Int!
    var username: String!
    var avatarUrl: String?
    var url: String!
    var createdAt: Date!
    
    // MARK: JSON
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        identifier <- map["id"]
        username <- map["login"]
        url <- map["url"]
        avatarUrl <- map["avatar_url"]
        
        let dateTransform = TransformOf<Date, String>(fromJSON: { (value) -> Date? in
            guard let value = value else { return nil }
            return Date.fromString(value, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        }, toJSON: {
            $0.map { String(describing: $0) }
        })
        createdAt <- (map["created_At"], dateTransform)
    }
    
}
