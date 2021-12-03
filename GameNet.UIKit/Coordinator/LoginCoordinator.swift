//
//  AppCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController = UIViewController()

    func start() {
        let vc = LoginViewController.instantiate()
        vc.coordinator = self
        
        self.rootViewController = vc
    }
    
    func loggedIn() {
        let tabBarCoordinator = MainTabBarCoordinator(rootViewController: self.rootViewController)
        tabBarCoordinator.start()
        
        childCoordinators.append(tabBarCoordinator)
    }
}
