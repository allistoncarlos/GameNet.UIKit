//
//  Swinject+Injector.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 18/05/22.
//

import Foundation
import SwinjectStoryboard

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
