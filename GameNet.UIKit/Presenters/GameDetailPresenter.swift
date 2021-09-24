//
//  GameDetailPresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/08/21.
//

import Foundation

protocol GameDetailPresenterProtocol: AnyObject {
    func get(id: String)
    func getGameplaySessions(id: String)
}

protocol GameDetailPresenterDelegate: AnyObject {
    func render(result: GameDetailViewModel?)
    func renderGameplays(result: GameplaySessionsViewModel?)
}

class GameDetailPresenter: GameDetailPresenterProtocol {
    private var service: ServiceBox<GameService>?
    private var gameplaySessionService: ServiceBox<GameplaySessionService>?
    private weak var delegate: GameDetailPresenterDelegate?

    init(delegate: GameDetailPresenterDelegate?, service: ServiceBox<GameService>?, gameplaySessionService: ServiceBox<GameplaySessionService>?) {
        self.service = service
        self.gameplaySessionService = gameplaySessionService
        self.delegate = delegate
    }
    
    // MARK: - GamePresenterProtocol
    func get(id: String) {
        service?.object.getGameDetail(id: id, completion: { (result) in
            switch result {
                case .success(let apiResult):
                    if apiResult.ok {
                        let viewModel = self.mapToViewModel(apiResult.data)
                        self.delegate?.render(result: viewModel)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    func getGameplaySessions(id: String) {
        gameplaySessionService?.object.getGameplaySessions(id: id, completion: { (result) in
            switch result {
                case .success(let apiResult):
                    if apiResult.ok {
                        let viewModel = self.mapGameplaysToViewModel(apiResult.data)
                        self.delegate?.renderGameplays(result: viewModel)
                    }
                case .failure(let error):
                    self.delegate?.renderGameplays(result: nil)
                    print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Private funcs
    private func mapToViewModel(_ apiResult: GameDetailModel) -> GameDetailViewModel {
        let viewModel = GameDetailViewModel(
            id: apiResult.id!,
            name: apiResult.name,
            cover: apiResult.cover,
            platform: apiResult.platform,
            value: apiResult.value,
            boughtDate: apiResult.boughtDate,
            gameplays: apiResult.gameplays?.map { GameplayViewModel(start: $0.start, finish: $0.finish) }
        )
        
        return viewModel
    }
    
    private func mapGameplaysToViewModel(_ apiResult: GameplaySessionsModel) -> GameplaySessionsViewModel {        
        let viewModel = GameplaySessionsViewModel(
            id: apiResult.id,
            totalGameplayTime: apiResult.totalGameplayTime,
            averageGameplayTime: apiResult.averageGameplayTime,
            sessions: apiResult.sessions.map { mapGameplaySessionToViewModel(model: $0) }
        )
        
        return viewModel
    }
    
    private func mapGameplaySessionToViewModel(model: GameplaySessionModel?) -> GameplaySessionViewModel? {
        if let model = model {
            return GameplaySessionViewModel(
                id: model.id,
                userId: model.userId,
                userGameId: model.userGameId,
                start: model.start,
                finish: model.finish,
                totalGameplayTime: model.totalGameplayTime
            )
        }
        
        return nil
    }
}
