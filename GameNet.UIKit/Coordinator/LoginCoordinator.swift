//
//  AppCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let vc = LoginViewController.instantiate()
        vc.coordinator = self
        
        self.rootViewController = vc
    }
    
    func loggedIn() {
        let tabBarCoordinator = TabBarCoordinator(rootViewController: MainTabBarViewController())
        
        let vc = MainTabBarViewController.instantiate()
        vc.coordinator = tabBarCoordinator
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.rootViewController.show(vc, sender: self)
        
        self.childCoordinators.append(TabBarCoordinator(rootViewController: vc))
        tabBarCoordinator.start()
    }
}
