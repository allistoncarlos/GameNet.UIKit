//
//  AppCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LoginViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func loggedIn() {
        let vc = MainTabBarViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
        navigationController.viewControllers.removeAll()
    }
}
