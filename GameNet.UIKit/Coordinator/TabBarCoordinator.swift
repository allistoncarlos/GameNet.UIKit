//
//  TabBarCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
        
        // TODO: - Colocar aqui os coordinators de Dashboard, Games, Plataformas e Listas
    }

    func start() {
        let vc = MainTabBarViewController.instantiate()
        vc.coordinator = self
        
        self.rootViewController = vc
    }
}
