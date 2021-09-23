//
//  GameplaySessionService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/09/21.
//

import Foundation

protocol GameplaySessionServiceProtocol: ServiceProtocol {
    func getGameplaySessions(id: String, completion: @escaping (Result<APIResult<GameplaySessionsModel>, Error>) -> Void)
}

class GameplaySessionService: Service<GameplaySessionsModel>, GameplaySessionServiceProtocol {
    typealias T = GameplaySessionsModel
    
    func getGameplaySessions(id: String, completion: @escaping (Result<APIResult<GameplaySessionsModel>, Error>) -> Void) {
        super.baseGet(id: nil, queryString: "userGameId=\(id)", completion: completion)
    }
}
