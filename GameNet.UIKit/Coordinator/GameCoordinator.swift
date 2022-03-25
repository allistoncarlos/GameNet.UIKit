//
//  GameCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 11/12/21.
//

import UIKit

class GameCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        if let navigationViewController = rootViewController as? UINavigationController,
           let gamesViewController = navigationViewController.children.first as? GamesViewController {
            gamesViewController.coordinator = self
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

    func showGame(id: String? = nil) {
        if let navigationController = self.rootViewController as? UINavigationController,
           let gamesViewController = navigationController.children.first as? GamesViewController,
           let editGameViewController = EditGameViewController.instantiate() {
            editGameViewController.modalPresentationStyle = .automatic
            editGameViewController.modalTransitionStyle = .crossDissolve
            editGameViewController.delegate = gamesViewController
            editGameViewController.gameId = id

            gamesViewController.present(UINavigationController(rootViewController: editGameViewController),
                                        animated: true, completion: nil)
        }
    }
}
