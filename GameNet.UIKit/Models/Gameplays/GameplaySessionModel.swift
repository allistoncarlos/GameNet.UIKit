//
//  GameplaySessionModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/09/21.
//

import Foundation

struct GameplaySessionModel: BaseModel {
    var id: String?
    var userId: String
    var userGameId: String
    var start: Date
    var finish: Date
    var totalGameplayTime: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case userGameId
        case start
        case finish
        case totalGameplayTime
    }
}
