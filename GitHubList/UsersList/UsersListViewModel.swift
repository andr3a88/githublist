//
//  UsersListViewModel.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UsersListViewModelCoordinatorDelegate: class {
    func usersListViewModelToUserDetail(user: User)
}

protocol UsersListViewModelType: class {
    var rx_title: Driver<String> { get }
    var rx_usersFetched: Observable<[User]> { get }
    weak var coordinatorDelegate: UsersListViewModelCoordinatorDelegate? { get set }
    
    func toUserDetail(user: User)
}

final class UsersListViewModel: UsersListViewModelType {
    
    // MARK: Coordinator Delegate
    
    weak var coordinatorDelegate: UsersListViewModelCoordinatorDelegate?
    
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
    
    func toUserDetail(user: User) {
        self.coordinatorDelegate?.usersListViewModelToUserDetail(user: user)
    }
}
