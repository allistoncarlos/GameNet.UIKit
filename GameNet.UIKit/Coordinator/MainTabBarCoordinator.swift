//
//  MainTabBarCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController = UIViewController()

    func start() {
        if let tabBarViewController = MainTabBarViewController.instantiate() {
            tabBarViewController.coordinator = self

            tabBarViewController.modalPresentationStyle = .fullScreen
            tabBarViewController.modalTransitionStyle = .crossDissolve

            self.rootViewController = tabBarViewController

            if let viewControllers = tabBarViewController.viewControllers {
                // Dashboard
                let dashboardNavigationController = viewControllers[0] as? UINavigationController
                let dashboardVC = dashboardNavigationController?.viewControllers.first as? DashboardViewController

                if let dashboardNavigationController = dashboardNavigationController {
                    let coordinator = DashboardCoordinator(rootViewController: dashboardNavigationController)
                    coordinator.start()

                    dashboardVC?.coordinator = coordinator

                    self.childCoordinators.append(coordinator)
                }

                // Games
                let gameNavigationController = viewControllers[1] as? UINavigationController
                let gamesVC = gameNavigationController?.viewControllers.first as? GamesViewController

                if let gameNavigationController = gameNavigationController {
                    let coordinator = GameCoordinator(rootViewController: gameNavigationController)
                    coordinator.start()

                    gamesVC?.coordinator = coordinator

                    self.childCoordinators.append(coordinator)
                }

                // Platforms
                let platformNavigationController = viewControllers[2] as? UINavigationController
                let platformsVC = platformNavigationController?.viewControllers.first as? PlatformsViewController

                if let platformNavigationController = platformNavigationController {
                    let coordinator = PlatformCoordinator(rootViewController: platformNavigationController)
                    coordinator.start()

                    platformsVC?.coordinator = coordinator

                    self.childCoordinators.append(coordinator)
                }

                // Lists
                let listNavigationController = viewControllers[3] as? UINavigationController
                let listsVC = listNavigationController?.viewControllers.first as? ListsViewController

                if let listNavigationController = listNavigationController {
                    let coordinator = ListCoordinator(rootViewController: listNavigationController)
                    coordinator.start()

                    listsVC?.coordinator = coordinator

                    self.childCoordinators.append(coordinator)
                }
            }
        }
    }
}
