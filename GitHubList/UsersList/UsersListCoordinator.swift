//
//  UsersListCoordinator.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

final class UsersListCoordinator: Coordinator, UsersListViewModelCoordinatorDelegate {
    
    // MARK: Properties
    
    private var usersListViewController: UsersListViewController?
    private var userDetailCoordinator: UserDetailCoordinator?
    
    private weak var navigationController: UINavigationController?
    
    // MARK: Methods
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateInitialViewController() as? UsersListViewController else {
            return
        }
        let dataProvider = UsersDataProvider()
        viewController.viewModel = UsersListViewModel(dataProvider: dataProvider)
        viewController.viewModel.coordinatorDelegate = self
        
        navigationController.pushViewController(viewController, animated: true)
        
        usersListViewController = viewController
    }
    
    func usersListViewModelToUserDetail(user: User) {
        guard let navigationController = navigationController else { return }
        
        userDetailCoordinator = UserDetailCoordinator(navigationController: navigationController, user: user)
        userDetailCoordinator?.start()
    }
}
