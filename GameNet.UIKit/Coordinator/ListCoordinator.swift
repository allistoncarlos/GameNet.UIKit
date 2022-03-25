//
//  ListCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/02/22.
//

import UIKit

class ListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        if let navigationViewController = rootViewController as? UINavigationController,
           let listsViewController = navigationViewController.children.first as? ListsViewController {
            listsViewController.coordinator = self
        }
    }

    func showList(id: String? = nil) {
        if let navigationController = self.rootViewController as? UINavigationController,
           let listsViewController = navigationController.children.first as? ListsViewController,
           let editListViewController = EditListViewController.instantiate() {
            editListViewController.modalPresentationStyle = .automatic
            editListViewController.modalTransitionStyle = .crossDissolve
            editListViewController.delegate = listsViewController
            editListViewController.listId = id

            listsViewController.present(UINavigationController(rootViewController: editListViewController),
                                        animated: true, completion: nil)
        }
    }
}
