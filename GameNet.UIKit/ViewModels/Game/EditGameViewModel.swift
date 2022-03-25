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

    var apiResult: APIResult<GameModel>? { get set }
    var platformsResult: APIResult<PagedResult<PlatformModel>>? { get set }

    func fetchData(id: String)
    func fetchPlatforms()
    func save(gameModel: GameEditModel, userGameModel: UserGameEditModel)
}

class EditGameViewModel: ObservableObject, EditGameViewModelProtocol {
    private var service: ServiceBox<GameService>?
    private var platformsService: ServiceBox<PlatformService>?

    var apiResult: APIResult<GameModel>? {
        didSet {
            renderData?()
        }
    }

    var platformsResult: APIResult<PagedResult<PlatformModel>>? {
        didSet {
            renderPlatformsData?()
        }
    }

    var renderData: (() -> Void)?
    var renderPlatformsData: (() -> Void)?
    var savedData: (() -> Void)?

    init(
        service: ServiceBox<GameService>?,
        platformsService: ServiceBox<PlatformService>?
    ) {
        self.service = service
        self.platformsService = platformsService
    }

    func fetchData(id: String) {
        service?.object.get(id: id, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func fetchPlatforms() {
        platformsService?.object.load(page: nil, pageSize: nil, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.platformsResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func save(gameModel: GameEditModel, userGameModel: UserGameEditModel) {
        service?.object.save(model: gameModel, completion: { [weak self] result in
            switch result {
            case .success(let resultGameModel):
                let keychain = Keychain(service: Constants.keychainIdentifier)

                guard let userId = keychain[Constants.userIdIdentifier],
                      let gameId = resultGameModel.data.id else { return }

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

                self?.saveUserGame(data: resultUserGameModel)
            case .failure(let error):
                print(error)
            }
        })
    }

    private func saveUserGame(data: UserGameEditModel) {
        service?.object.saveUserGame(model: data, completion: { [weak self] result in
            switch result {
            case .success:
                self?.savedData?()
            case .failure(let error):
                print(error)
            }
        })
    }
}
