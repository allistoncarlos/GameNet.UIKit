//
//  MainTabBarCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let tabBarViewController = MainTabBarViewController.instantiate()
        tabBarViewController.coordinator = self
        tabBarViewController.modalPresentationStyle = .fullScreen
        tabBarViewController.modalTransitionStyle = .crossDissolve
        
        self.rootViewController.show(tabBarViewController, sender: self)
        
        if let viewControllers = tabBarViewController.viewControllers {
            // Dashboard

            // Platforms
            let platformNavigationController = viewControllers[2] as? UINavigationController
            let platformsVC = platformNavigationController?.viewControllers.first as? PlatformsViewController

            if let platformNavigationController = platformNavigationController {
                let coordinator = PlatformCoordinator(rootViewController: platformNavigationController)
                coordinator.start()

                platformsVC?.coordinator = coordinator

                self.childCoordinators.append(coordinator)
            }
        }
    }
}
