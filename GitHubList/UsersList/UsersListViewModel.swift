//
//  UsersListViewModel.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UsersListViewModelType: class {
    var rx_title: Driver<String> { get }
    var rx_usersFetched: Observable<[User]> { get }
}

final class UsersListViewModel: UsersListViewModelType {
    
    // MARK: Properties
    var rx_title: Driver<String> = .just("Users List")
    var rx_usersFetched: Observable<[User]>
    
    private var dataProvider: UsersDataProviderType
    
    // MARK: Methods
    
    init(dataProvider: UsersDataProviderType) {
        self.dataProvider = dataProvider
        
        rx_usersFetched = dataProvider.fetchData()
            .shareReplay(1)
    }
}
