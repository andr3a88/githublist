//
//  AppDelegate.swift
//  GitHubList
//
//  Created by Andrea on 13/05/2017.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()
    
    private var mainCoordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = navigationController
        let coordinator = UsersListCoordinator(navigationController: navigationController)
        coordinator.start()
        window?.makeKeyAndVisible()
        
        mainCoordinator = coordinator
        
        return true
    }
}
