//
//  PlatformCoordinator.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 02/12/21.
//

import UIKit

class PlatformCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let navigationViewController = rootViewController as! UINavigationController
        let platformsViewController = navigationViewController.children.first as! PlatformsViewController
        platformsViewController.coordinator = self
    }
    
    func showPlatform(id: String? = nil) {
        let navigationController = self.rootViewController as! UINavigationController
        let platformsViewController = navigationController.children.first as! PlatformsViewController
        let editPlatformViewController = EditPlatformViewController.instantiate()
        editPlatformViewController.modalPresentationStyle = .automatic
        editPlatformViewController.modalTransitionStyle = .crossDissolve
        editPlatformViewController.delegate = platformsViewController
        editPlatformViewController.platformId = id
        
        platformsViewController.present(editPlatformViewController, animated: true, completion: nil)
    }
}
