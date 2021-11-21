//
//  GameEditModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 18/11/21.
//

import Foundation

struct GameEditModel: BaseModel {
    var id: String?
    var name: String
    var cover: Data
    var platformId: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "gameName"
        case cover = "gameCoverURL"
        case platformId
    }
}

struct UserGameEditModel: BaseModel {
    var id: String?
    var gameId: String
    var userId: String
    var price: Double
    var boughtDate: Date
    var have: Bool
    var want: Bool
    var digital: Bool
    var original: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case gameId
        case userId
        case price
        case boughtDate
        case have
        case want
        case digital
        case original
    }
}
