//
//  UserGameEditResponseModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation

struct UserGameEditResponseModel: BaseModel {
    var id: String?
    var userId: String
    var gameId: String
    var name: String?
    var cover: String?
    var platformId: String?
    var platform: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case gameId
        case name = "gameName"
        case cover = "gameCoverURL"
        case platformId
        case platform = "platformName"
    }
}
