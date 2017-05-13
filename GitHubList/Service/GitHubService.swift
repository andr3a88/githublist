//
//  GitHubService.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Foundation
import Moya

enum GitHubService {
    case allUsers
    case searchUsers(query: String, perPage: String, page: String)
    case showUser(username: String)
}

// MARK: - TargetType Protocol Implementation

extension GitHubService: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .allUsers:
            return "/users"
        case .searchUsers:
            return "/search/users"
        case .showUser(let username):
            return "/users/\(username)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allUsers, .searchUsers, .showUser:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .allUsers:
            return nil
        case .searchUsers(let query, let perPage, let page):
            return ["q": query, "per_page": perPage, "page": page]
        case .showUser:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .allUsers, .searchUsers, .showUser:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .allUsers, .showUser:
            return "{\"id\": \"131231\", \"login\": \"carlosengr\", \"avatar_url\": \"https://avatars3.githubusercontent.com/u/6755254?v=3\"}".utf8Encoded
        case .searchUsers:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .allUsers, .searchUsers, .showUser:
            return .request
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
