//
//  GameDetailModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/08/21.
//

import Foundation

struct GameDetailModel: BaseModel {
    var id: String?
    var name: String
    var cover: String
    var platform: String
    var value: Decimal
    var boughtDate: Date
    var gameplays: [GameplayModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "gameName"
        case cover = "gameCoverURL"
        case platform = "platformName"
        case value
        case boughtDate
        case gameplays
    }
}
