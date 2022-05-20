//
//  GameDetailViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation
import GameNet_Network

protocol GameDetailViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var renderGameplayData: (() -> Void)? { get set }
    var result: GameDetail? { get set }
    var gameplayResult: GameplaySessions? { get set }

    func fetchData(id: String) async
    func fetchGameplaySessions(id: String) async
}

class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol {
    var result: GameDetail? {
        didSet {
            renderData?()
        }
    }

    var gameplayResult: GameplaySessions? {
        didSet {
            renderGameplayData?()
        }
    }

    var renderData: (() -> Void)?
    var renderGameplayData: (() -> Void)?

    // MARK: - GameDetailViewModelProtocol
    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<GameDetailResponse>.self,
                endpoint: .game(id: id)) {

            if apiResult.ok {
                self.result = apiResult.data.toGameDetail()
            }
        }
    }

    func fetchGameplaySessions(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<GameplaySessionsResponse>.self,
                endpoint: .gameplays(id: id)) {

            if apiResult.ok {
                self.gameplayResult = apiResult.data.toGameplaySessions()
            }
        }
    }
}
