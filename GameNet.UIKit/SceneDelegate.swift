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
    var coordinator: LoginCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if !hasValidToken() {
            guard let windowScene = scene as? UIWindowScene else { return }
            
            coordinator = LoginCoordinator()
            coordinator?.start()

            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = coordinator?.rootViewController
            window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

    // MARK: - Private methods
    private func hasValidToken() -> Bool {
        let keychain = Keychain(service: Constants.keychainIdentifier)
        
        // ESSA VERIFICAÇÃO É TEMPORÁRIA
        guard let _ = keychain[Constants.userIdIdentifier],
              let _ = keychain[Constants.accessTokenIdentifier],
              let _ = keychain[Constants.refreshTokenIdentifier],
              let expiresIn = keychain[Constants.expiresInIdentifier]?.toDate() else { return false }
        
        if expiresIn > NSDate.init() as Date {
            return true
        }
        
        keychain[Constants.userIdIdentifier] = nil
        keychain[Constants.accessTokenIdentifier] = nil
        keychain[Constants.refreshTokenIdentifier] = nil
        keychain[Constants.expiresInIdentifier] = nil
        
        return false
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { r, c in
            c.viewModel = UserViewModel(service: r.resolve(UserServiceProtocol.self))
        }
        defaultContainer.storyboardInitCompleted(DashboardViewController.self) { r, c in
            c.viewModel = DashboardViewModel(service: r.resolve(ServiceBox<DashboardService>.self))
        }
        defaultContainer.storyboardInitCompleted(GamesViewController.self) { r, c in
            c.viewModel = GamesViewModel(service: r.resolve(ServiceBox<GameService>.self))
        }
        defaultContainer.storyboardInitCompleted(GameDetailViewController.self) { r, c in
            c.viewModel = GameDetailViewModel(
                service: r.resolve(ServiceBox<GameService>.self),
                gameplaySessionService: r.resolve(ServiceBox<GameplaySessionService>.self))
        }
        defaultContainer.storyboardInitCompleted(EditGameViewController.self) { r, c in
            c.viewModel = EditGameViewModel(service: r.resolve(ServiceBox<GameService>.self),
                                            platformsService: r.resolve(ServiceBox<PlatformService>.self))
        }
        defaultContainer.storyboardInitCompleted(PlatformsViewController.self) { r, c in
            c.viewModel = PlatformsViewModel(service: r.resolve(ServiceBox<PlatformService>.self))
        }
        defaultContainer.storyboardInitCompleted(EditPlatformViewController.self) { r, c in
            c.viewModel = EditPlatformViewModel(service: r.resolve(ServiceBox<PlatformService>.self))
        }
        defaultContainer.storyboardInitCompleted(ListsViewController.self) { r, c in
            c.viewModel = ListsViewModel(service: r.resolve(ServiceBox<ListService>.self))
        }
        defaultContainer.storyboardInitCompleted(EditListViewController.self) { r, c in
            c.viewModel = EditListViewModel(service: r.resolve(ServiceBox<ListService>.self))
        }
        
        
        // Services
        defaultContainer.register(UserServiceProtocol.self) { _ in UserService() }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<DashboardService>(object: DashboardService(apiResource: Constants.dashboardResource))
        }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<GameService>(object: GameService(apiResource: Constants.gameResource))
        }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<GameplaySessionService>(object: GameplaySessionService(apiResource: Constants.gameplaySessionResource))
        }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<PlatformService>(object: PlatformService(apiResource: Constants.platformResource))
        }
        defaultContainer.register(ServiceBox.self) { _ in
            ServiceBox<ListService>(object: ListService(apiResource: Constants.listResource))
        }
    }
}
