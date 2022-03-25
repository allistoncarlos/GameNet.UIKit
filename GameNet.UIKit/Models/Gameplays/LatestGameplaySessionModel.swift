//
//  GameplaySessionModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct LatestGameplaySessionModel: BaseModel {
    var id: String?
    var userId: String
    var userGameId: String
    var start: Date
    var finish: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case userGameId
        case start
        case finish
    }
}
