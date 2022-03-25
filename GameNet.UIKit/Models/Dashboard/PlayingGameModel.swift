//
//  PlayingGameModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct PlayingGameModel: BaseModel {
    var id: String?
    var name: String
    var platform: String
    var latestGameplaySession: LatestGameplaySessionModel?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case platform
        case latestGameplaySession
    }
}
