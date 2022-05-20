//
//  EditGameViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 19/10/21.
//

import Foundation
import GameNet_Network
import KeychainAccess

protocol EditGameViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var renderPlatformsData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: Game? { get set }
    var platformsResult: [Platform] { get set }

    func fetchData(id: String) async
    func fetchPlatforms() async
    func save(data: Game, userGameData: UserGame) async
}

class EditGameViewModel: ObservableObject, EditGameViewModelProtocol {
    private var gamesViewModel: GamesViewModelProtocol?
    private var platformsViewModel: PlatformsViewModelProtocol?

    var result: Game? {
        didSet {
            renderData?()
        }
    }

    var platformsResult: [Platform] = [] {
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

    func save(data: Game, userGameData: UserGame) async {
        if let apiResult = await NetworkManager.shared
            .performUploadGame(data: data.toRequest()) {
            if apiResult.ok {
                guard let userId = KeychainDataSource.id.get(),
                      let gameId = apiResult.data.id else { return }

                let resultUserGameRequest = UserGameEditRequest(id: nil,
                                                                gameId: gameId,
                                                                userId: userId,
                                                                price: userGameData.price,
                                                                boughtDate: userGameData.boughtDate,
                                                                have: userGameData.have,
                                                                want: userGameData.want,
                                                                digital: userGameData.digital,
                                                                original: userGameData.original)

                await self.saveUserGame(data: resultUserGameRequest)
            }
        }
    }

    private func saveUserGame(data: UserGameEditRequest) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<UserGameEditResponse>.self,
                endpoint: .saveUserGame(data: data)) {
            if apiResult.ok {
                if let name = apiResult.data.name,
                   let cover = apiResult.data.cover,
                   let platformId = apiResult.data.platformId,
                   let platform = apiResult.data.platform {
                    self.result = Game(id: apiResult.data.id,
                                       name: name,
                                       cover: nil,
                                       coverURL: cover,
                                       platformId: platformId,
                                       platform: platform)

                    self.savedData?()
                }
            }
        }
    }
}
