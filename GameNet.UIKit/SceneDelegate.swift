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
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { _, container in
            container.viewModel = UserViewModel()
        }
        defaultContainer.storyboardInitCompleted(DashboardViewController.self) { _, container in
            container.viewModel = DashboardViewModel()
        }
        defaultContainer.storyboardInitCompleted(GamesViewController.self) { resolver, container in
            container.viewModel = GamesViewModel(service: resolver.resolve(ServiceBox<GameService>.self))
        }
        defaultContainer.storyboardInitCompleted(GameDetailViewController.self) { resolver, container in
            container.viewModel = GameDetailViewModel(
                service: resolver.resolve(ServiceBox<GameService>.self),
                gameplaySessionService: resolver.resolve(ServiceBox<GameplaySessionService>.self))
        }
        defaultContainer.storyboardInitCompleted(EditGameViewController.self) { resolver, container in
            container.viewModel = EditGameViewModel(service: resolver.resolve(ServiceBox<GameService>.self),
                                            platformsService: resolver.resolve(ServiceBox<PlatformService>.self))
        }
        defaultContainer.storyboardInitCompleted(PlatformsViewController.self) { resolver, container in
            container.viewModel = resolver.resolve(PlatformsViewModelProtocol.self)
        }
        defaultContainer.storyboardInitCompleted(EditPlatformViewController.self) { resolver, container in
            container.viewModel = EditPlatformViewModel(service: resolver.resolve(ServiceBox<PlatformService>.self))
        }
        defaultContainer.storyboardInitCompleted(ListsViewController.self) { resolver, container in
            container.viewModel = ListsViewModel(service: resolver.resolve(ListServiceProtocol.self))
        }
        defaultContainer.storyboardInitCompleted(EditListViewController.self) { resolver, container in
            container.viewModel = EditListViewModel(service: resolver.resolve(ServiceBox<ListService>.self))
        }

        // Services
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<GameService>(object: GameService(apiResource: Constants.gameResource))
        }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<GameplaySessionService>(object: GameplaySessionService(
                apiResource: Constants.gameplaySessionResource))
        }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<PlatformService>(object: PlatformService(apiResource: Constants.platformResource))
        }

        defaultContainer.register(ListServiceProtocol.self) { _ in
            ListService(apiResource: Constants.listResource)
        }

        // ViewModels
        defaultContainer.register(PlatformsViewModelProtocol.self) { resolver in
            PlatformsViewModel(service: resolver.resolve(ServiceBox<PlatformService>.self))
        }

        defaultContainer.register(ListDetailViewModelProtocol.self) { resolver in
            ListDetailViewModel(service: resolver.resolve(ListServiceProtocol.self))
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
