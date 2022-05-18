//
//  EditGameViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 19/10/21.
//

import Foundation
import KeychainAccess

protocol EditGameViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var renderPlatformsData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: GameModel? { get set }
    var platformsResult: [PlatformModel] { get set }

    func fetchData(id: String) async
    func fetchPlatforms() async
    func save(gameModel: GameEditModel, userGameModel: UserGameEditModel) async
}

class EditGameViewModel: ObservableObject, EditGameViewModelProtocol {
    private var gamesViewModel: GamesViewModelProtocol?
    private var platformsViewModel: PlatformsViewModelProtocol?

    var result: GameModel? {
        didSet {
            renderData?()
        }
    }

    var platformsResult: [PlatformModel] = [] {
        didSet {
            renderPlatformsData?()
        }
    }

    var renderData: (() -> Void)?
    var renderPlatformsData: (() -> Void)?
    var savedData: (() -> Void)?

    init(
        gamesViewModel: GamesViewModelProtocol?,
        platformsViewModel: PlatformsViewModelProtocol?
    ) {
        self.gamesViewModel = gamesViewModel
        self.platformsViewModel = platformsViewModel
    }

    func fetchData(id: String) async {
        guard let gamesViewModel = gamesViewModel else { return }
        
        await gamesViewModel.fetchData(id: id)
        self.result = gamesViewModel.result
    }

    func fetchPlatforms() async {
        guard let platformsViewModel = platformsViewModel else { return }

        await platformsViewModel.fetchData()
        self.platformsResult = platformsViewModel.result
    }

    func save(gameModel: GameEditModel, userGameModel: UserGameEditModel) async {
        if let apiResult = await NetworkManager.shared
            .performUploadGame(model: gameModel) {
            if apiResult.ok {
                guard let userId = KeychainDataSource.id.get(),
                      let gameId = apiResult.data.id else { return }

                let resultUserGameModel = UserGameEditModel(
                    id: nil,
                    gameId: gameId,
                    userId: userId,
                    price: userGameModel.price,
                    boughtDate: userGameModel.boughtDate,
                    have: userGameModel.have,
                    want: userGameModel.want,
                    digital: userGameModel.digital,
                    original: userGameModel.original)

                await self.saveUserGame(data: resultUserGameModel)
            }
        }
    }

    private func saveUserGame(data: UserGameEditModel) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<UserGameEditResponseModel>.self,
                endpoint: .saveUserGame(model: data)) {
            if apiResult.ok {
                if let name = apiResult.data.name,
                   let cover = apiResult.data.cover,
                   let platformId = apiResult.data.platformId,
                   let platform = apiResult.data.platform {
                    self.result = GameModel(id: apiResult.data.id,
                                            name: name,
                                            cover: cover,
                                            platformId: platformId,
                                            platform: platform)

                    self.savedData?()
                }
            }
        }
    }
}
