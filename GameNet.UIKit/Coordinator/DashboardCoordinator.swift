//
//  DashboardCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/02/22.
//

import UIKit
import SwinjectStoryboard

class DashboardCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        if let navigationViewController = rootViewController as? UINavigationController,
           let dashboardViewController = navigationViewController.children.first as? DashboardViewController {
            dashboardViewController.coordinator = self
        }
    }

    func showGameDetail(id: String, name: String) {
        if let navigationViewController = rootViewController as? UINavigationController,
           let gameDetailViewController = GameDetailViewController.instantiate() {
            gameDetailViewController.gameId = id
            gameDetailViewController.title = name

            navigationViewController.pushViewController(gameDetailViewController, animated: true)
        }
    }

    func showListDetail(id: String, listType: ListType) {
        if let navigationViewController = rootViewController as? UINavigationController,
           let mainTabBarViewController = navigationViewController
                .topViewController?.tabBarController as? MainTabBarViewController {
            let listDetailViewController = ListDetailViewController()
            let viewModel = SwinjectStoryboard.defaultContainer.resolve(ListDetailViewModelProtocol.self)

            let listCoordinator = mainTabBarViewController.coordinator?.childCoordinators.first {
                $0 is ListCoordinator
            } as? ListCoordinator

            listCoordinator?.parentCoordinator = self
            listDetailViewController.coordinator = listCoordinator
            listDetailViewController.viewModel = viewModel
            listDetailViewController.listId = id
            listDetailViewController.listType = listType

            navigationViewController.pushViewController(listDetailViewController, animated: true)
        }
    }
}
