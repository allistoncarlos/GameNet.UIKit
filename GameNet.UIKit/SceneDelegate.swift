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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if !hasValidToken() {
            guard let windowScene = scene as? UIWindowScene else { return }
            
            let viewController = storyboard.instantiateViewController (withIdentifier: "LoginViewController")
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = viewController
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
        if keychain[Constants.accessTokenIdentifier] != nil &&
            keychain[Constants.refreshTokenIdentifier] != nil &&
            keychain[Constants.expiresInIdentifier] != nil {
            return true
        }
        
        return false
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { r, c in
            c.presenter = UserPresenter(delegate: c, service: r.resolve(UserServiceProtocol.self))
        }
        defaultContainer.storyboardInitCompleted(DashboardViewController.self) { r, c in
            c.presenter = DashboardPresenter(delegate: c, service: r.resolve(ServiceBox<DashboardService>.self))
        }
        defaultContainer.storyboardInitCompleted(GamesViewController.self) { r, c in
            c.presenter = GamePresenter(delegate: c, service: r.resolve(ServiceBox<GameService>.self))
        }
        defaultContainer.storyboardInitCompleted(PlatformsViewController.self) { r, c in
            c.presenter = PlatformPresenter(delegate: c, service: r.resolve(ServiceBox<PlatformService>.self))
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
            ServiceBox<PlatformService>(object: PlatformService(apiResource: Constants.platformResource))
        }
    }
}
