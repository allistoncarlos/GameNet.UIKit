//
//  GameService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation

protocol GameServiceProtocol: ServiceProtocol {
    func getGameDetail(id: String?, completion: @escaping (Result<APIResult<GameDetailModel>, Error>) -> Void)
}

class GameService: Service<GameModel>, GameServiceProtocol {
    typealias T = GameModel
    
    func getGameDetail(id: String? = nil, completion: @escaping (Result<APIResult<GameDetailModel>, Error>) -> Void) {
        super.baseGet(id: id, completion: completion)
    }
}
