//
//  GameModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation

struct GameModel: BaseModel {
    var id: String?
    var name: String
    var cover: String
    var platformId: String
    var platform: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "gameName"
        case cover = "gameCoverURL"
        case platformId
        case platform = "platformName"
    }
}
