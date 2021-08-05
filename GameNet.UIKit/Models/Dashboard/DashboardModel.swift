//
//  DashboardModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct DashboardModel: BaseModel {
    var id: String?
    var boughtByYear: [BoughtGamesByYearTotalModel]?
    var finishedByYear: [FinishedGameByYearTotalModel]?
    var playingGames: [PlayingGameModel]?
    var physicalDigital: PhysicalDigitalModel?
    var gamesByPlatform: PlatformGamesModel?
    var totalPrice: Decimal?
    var totalGames: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case boughtByYear
        case finishedByYear
        case playingGames
        case physicalDigital
        case gamesByPlatform
        case totalPrice
        case totalGames
    }
}
