//
//  UserDetailProvider.swift
//  GitHubList
//
//  Created by Andrea Stevanato on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import ObjectMapper
import RxSwift
import Moya

protocol UserDataProviderType {
    func fetchData() -> Observable<User>
}

final class UserDataProvider: UserDataProviderType {
    
    // MARK: Properties
    
    private var user: User
    
    // MARK: Methods
    
    init(user: User) {
        self.user = user
    }
    
    func fetchData() -> Observable<User> {
        guard let username = user.username else {
            return Observable.error(NSError(domain: "NoUserFound", code: 0, userInfo: nil))
        }
        return RxMoyaProvider<GitHubService>().request(.showUser(username: username))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .flatMapLatest(parseResponse)
    }
    
    private func parseResponse(data: Any) -> Observable<User> {
        guard let json = data as? [String: Any],
            let user = self.parseUser(from: json) else {
                let error = NSError(domain: "ParsingError", code: 0, userInfo: nil)
                return Observable.error(error)
        }
        return Observable.just(user)
    }
    
    private func parseUser(from json: [String: Any]) -> User? {
        return Mapper<User>().map(JSON: json)
    }
}
