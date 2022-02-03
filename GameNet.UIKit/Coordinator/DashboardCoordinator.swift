//
//  DashboardCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/02/22.
//

import UIKit

class DashboardCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let navigationViewController = rootViewController as! UINavigationController
        let dashboardViewController = navigationViewController.children.first as! DashboardViewController
        dashboardViewController.coordinator = self
    }
  
    func showGameDetail(id: String, name: String) {
        let navigationViewController = rootViewController as! UINavigationController
        let gameDetailViewController = GameDetailViewController.instantiate()
        gameDetailViewController.gameId = id
        gameDetailViewController.title = name
        
        navigationViewController.pushViewController(gameDetailViewController, animated: true)
    }
}
