//
//  SceneDelegate.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import KeychainAccess
import Swinject
import SwinjectStoryboard

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    let offlineAlertController: UIAlertController = {
        let alert = UIAlertController(title: "No Network",
                                      message: "Please connect to network and try again",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            NetworkReachability.shared.startNetworkMonitoring()
        }
        alert.addAction(action)
        return alert
    }()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        coordinator = !KeychainDataSource.hasValidToken() ? LoginCoordinator() : MainTabBarCoordinator()
        coordinator?.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()

        NetworkReachability.shared.delegate = self
        NetworkReachability.shared.startNetworkMonitoring()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded
        // (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(UserViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(DashboardViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(DashboardViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(GamesViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(GamesViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(GameDetailViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(GameDetailViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(EditGameViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(EditGameViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(PlatformsViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(PlatformsViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(EditPlatformViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(EditPlatformViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(ListsViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(ListsViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(EditListViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(EditListViewModelProtocol.self)
        }

        // ViewModels
        defaultContainer.register(UserViewModelProtocol.self) { _ in UserViewModel() }
        defaultContainer.register(DashboardViewModelProtocol.self) { _ in DashboardViewModel() }
        defaultContainer.register(GamesViewModelProtocol.self) { _ in GamesViewModel() }
        defaultContainer.register(GameDetailViewModelProtocol.self) { _ in GameDetailViewModel() }
        defaultContainer.register(PlatformsViewModelProtocol.self) { _ in PlatformsViewModel() }
        defaultContainer.register(EditPlatformViewModelProtocol.self) { _ in EditPlatformViewModel() }
        defaultContainer.register(ListsViewModelProtocol.self) { _ in ListsViewModel() }
        defaultContainer.register(EditListViewModelProtocol.self) { _ in EditListViewModel() }
        defaultContainer.register(ListDetailViewModelProtocol.self) { _ in ListDetailViewModel() }

        defaultContainer.register(EditGameViewModelProtocol.self) { resolver in
            EditGameViewModel(
                gamesViewModel: resolver.resolve(GamesViewModelProtocol.self),
                platformsViewModel: resolver.resolve(PlatformsViewModelProtocol.self))
        }
    }
}

extension SceneDelegate: NetworkReachabilityDelegate {
    func showOfflineAlert() {
        let rootViewController = window?.rootViewController
        rootViewController?.present(offlineAlertController, animated: true, completion: nil)
    }

    func dismissOfflineAlert() {
        let rootViewController = window?.rootViewController
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
