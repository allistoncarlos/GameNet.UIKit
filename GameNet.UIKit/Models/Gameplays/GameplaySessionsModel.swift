//
//  GameplaySessionsModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/09/21.
//

import Foundation

struct GameplaySessionsModel: BaseModel {
    var id: String?
    var sessions: [GameplaySessionModel]
    var totalGameplayTime: String
    var averageGameplayTime: String
    
    enum CodingKeys: String, CodingKey {
        case sessions
        case totalGameplayTime
        case averageGameplayTime
    }
}
