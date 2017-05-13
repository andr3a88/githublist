//
//  UserDetailViewModel.swift
//  GitHubList
//
//  Created by Andrea Stevanato on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UserDetailViewModelType: class {
    var rx_title: Driver<String> { get }
    var rx_username: Driver<String> { get }
    
    var user: Observable<User> { get set }
}

final class UserDetailViewModel: UserDetailViewModelType {
    
    // MARK: Properties
    
    var rx_title: Driver<String> = .just("User Detail")
    var rx_username: Driver<String> = .just("")
    
    var user: Observable<User>
    
    private var dataProvider: UserDataProviderType
    
    // MARK: Methods
    
    init(dataProvider: UserDataProviderType) {
        self.dataProvider = dataProvider
        
        user = dataProvider.fetchData().shareReplay(1)
    }
}
