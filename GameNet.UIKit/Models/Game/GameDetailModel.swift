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

/*
 "userId": "60d488293531bbbf8a1c8111",
         "gameId": "606740ebee7c498f676fb005",
         "value": 0,
         "boughtDate": "2021-04-02T00:00:00Z",
         "have": true,
         "want": false,
         "digital": true,
         "original": true,
         "gameName": "Fantasian",
         "gameCoverURL": "http://allistoncarlos.blob.core.windows.net/gamenet/apple-arcade/fantasian.jpg",
         "platformName": "Apple Arcade",
         "gameplays": [
             {
                 "start": "2021-04-02T10:53:01Z",
                 "finish": null
             }
         ],
         "id": "606741598843d4dbcd05d274"
 */
