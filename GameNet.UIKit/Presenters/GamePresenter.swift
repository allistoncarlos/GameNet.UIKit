//
//  GamePresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/06/21.
//

import Foundation

protocol GamePresenterProtocol: AnyObject {
    func load()
}

protocol GamePresenterDelegate: AnyObject {
    func render(games: [GameViewModel])
}

class GamePresenter: GamePresenterProtocol {
    private var service: GameService
    private weak var delegate: GamePresenterDelegate?
    private var apiResult: APIResult<PagedResult<GameModel>>?
    private var gamesViewModel: [GameViewModel] = []

    init(service: GameService, delegate: GamePresenterDelegate?) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - GamePresenterProtocol
    func load() {
        service.load(completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
                
                if apiResult.ok {
                    // TODO: Será que preciso passar o PagedResult pra view, em caso de paginação? ver depois...
                    self.gamesViewModel = self.mapToViewModel(apiResult.data.result)
                }
                
                self.delegate?.render(games: self.gamesViewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Private funcs
    private func mapToViewModel(_ games: [GameModel]) -> [GameViewModel] {
        return games.map { game in
            GameViewModel(id: game.id, name: game.name, cover: game.cover, platformId: game.platformId, platform: game.platform)
        }
    }
}

/*
 protocol UserPresenterProtocol: AnyObject {
     func login(username: String, password: String)
     func hasValidToken() -> Bool
 }

 protocol UserPresenterDelegate: AnyObject {
     
 }

 class UserPresenter: UserPresenterProtocol {
     private var service: UserServiceProtocol
     private weak var delegate: UserPresenterDelegate?
     
     init(service: UserServiceProtocol, delegate: UserPresenterDelegate?) {
         self.service = service
         self.delegate = delegate
     }
     
     // MARK: - UserPresenterProtocol
     func login(username: String, password: String) {
         service.login(LoginRequestModel: LoginRequestModel(username: username, password: password))
         { (result) in
             switch result {
                 case .success(let user):
                     self.saveToken(token: user.token)
                 case .failure(let error):
                     print(error.localizedDescription)
             }
         }
     }
     
     func hasValidToken() -> Bool {
         let keychain = Keychain(service: Constants.keychainIdentifier)
         if keychain[Constants.tokenIdentifier] != nil {
             return true
         }
         
         return false
     }
     
     // MARK: - Private funcs
     private func saveToken(token: String) {
         let keychain = Keychain(service: Constants.keychainIdentifier)
         keychain[Constants.tokenIdentifier] = token
     }
 }

 */
