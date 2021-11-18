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
