//
//  UsersDataProvider.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import ObjectMapper
import RxSwift
import Moya

protocol UsersDataProviderType {
    func fetchData() -> Observable<[User]>
}

final class UsersDataProvider: UsersDataProviderType {
    
    func fetchData() -> Observable<[User]> {
        return RxMoyaProvider<GitHubService>().request(.allUsers)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .flatMap(parseResponse)
    }
    
    private func parseResponse(data: Any) -> Observable<[User]> {
        guard let json = data as? [[String: Any]],
            let users = self.parseUsers(from: json) else {
                let error = NSError(domain: "ParsingError", code: 0, userInfo: nil)
                return Observable.error(error)
        }
        return Observable.just(users)
    }
    
    private func parseUsers(from json: [[String: Any]]) -> [User]? {
        return Mapper<User>().mapArray(JSONArray: json)
    }
}
