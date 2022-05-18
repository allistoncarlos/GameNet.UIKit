//
//  GameDetailViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation

protocol GameDetailViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var renderGameplayData: (() -> Void)? { get set }
    var result: GameDetailModel? { get set }
    var gameplayResult: GameplaySessionsModel? { get set }

    func fetchData(id: String) async
    func fetchGameplaySessions(id: String) async
}

class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol {
    private var service: ServiceBox<GameService>?
    private var gameplaySessionService: ServiceBox<GameplaySessionService>?

    var result: GameDetailModel? {
        didSet {
            renderData?()
        }
    }

    var gameplayResult: GameplaySessionsModel? {
        didSet {
            renderGameplayData?()
        }
    }

    var renderData: (() -> Void)?
    var renderGameplayData: (() -> Void)?

    init(service: ServiceBox<GameService>?,
         gameplaySessionService: ServiceBox<GameplaySessionService>?) {
        self.service = service
        self.gameplaySessionService = gameplaySessionService
    }

    // MARK: - GameDetailViewModelProtocol
    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<GameDetailModel>.self,
                endpoint: .game(id: id)) {

            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }

    func fetchGameplaySessions(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<GameplaySessionsModel>.self,
                endpoint: .gameplays(id: id)) {

            if apiResult.ok {
                self.gameplayResult = apiResult.data
            }
        }
    }
}
