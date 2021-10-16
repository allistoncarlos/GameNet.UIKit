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
    var apiResult: APIResult<GameDetailModel>? { get set }
    var apiGameplayResult: APIResult<GameplaySessionsModel>? { get set }
    
    func get(id: String)
    func getGameplaySessions(id: String)
}

class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol {
    private var service: ServiceBox<GameService>?
    private var gameplaySessionService: ServiceBox<GameplaySessionService>?
    
    var apiResult: APIResult<GameDetailModel>? {
        didSet {
            renderData?()
        }
    }
    
    var apiGameplayResult: APIResult<GameplaySessionsModel>? {
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
    func get(id: String) {
        service?.object.getGameDetail(id: id, completion: { (result) in
            switch result {
                case .success(let apiResult):
                    self.apiResult = apiResult
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    func getGameplaySessions(id: String) {
        gameplaySessionService?.object.getGameplaySessions(id: id, completion: { (result) in
            switch result {
                case .success(let apiResult):
                    self.apiGameplayResult = apiResult
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
}
