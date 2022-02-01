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
        let tabBarCoordinator = MainTabBarCoordinator()
        tabBarCoordinator.start()

        self.rootViewController.show(tabBarCoordinator.rootViewController, sender: nil)
        
        childCoordinators.append(tabBarCoordinator)
    }
}
