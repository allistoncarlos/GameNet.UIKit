//
//  ListItemModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/03/22.
//

import Foundation

struct ListItemModel: BaseModel {
    var id: String?
    var name: String?
    var platform: String?
    var year: Int?
    var userGameId: String?
    var boughtDate: Date?
    var value: Decimal?
    var start: Date?
    var finish: Date?
    var cover: String?
    var order: Int?
    var comment: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "gameName"
        case platform = "platformName"
        case year
        case userGameId
        case boughtDate
        case value
        case start
        case finish
        case cover
        case order
        case comment
    }
}

struct ListGameModel: BaseModel {
    var id: String?
    var name: String?
    var creationDate: Date?
    var games: [ListItemModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case creationDate
        case games
    }
}
