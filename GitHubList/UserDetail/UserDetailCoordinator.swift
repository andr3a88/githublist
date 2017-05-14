//
//  UserDetailCoordinator.swift
//  GitHubList
//
//  Created by Andrea Stevanato on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

final class UserDetailCoordinator: Coordinator {
    
    // MARK: Properties
    
    private weak var userDetailViewController: UserDetailViewController?
    private weak var navigationController: UINavigationController?
    
    private let user: User
    
    // MARK: Methods
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UserDetail") as? UserDetailViewController else {
            return
        }
        let dataProvider = UserDataProvider(user: user)
        viewController.viewModel = UserDetailViewModel(dataProvider: dataProvider)
        
        navigationController.pushViewController(viewController, animated: true)
        
        userDetailViewController = viewController
    }
}
