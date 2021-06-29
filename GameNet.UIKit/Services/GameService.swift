//
//  GameService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation

protocol GameServiceProtocol: ServiceProtocol {
    
}

class GameService: Service<GameModel>, GameServiceProtocol {
    typealias T = GameModel
}
