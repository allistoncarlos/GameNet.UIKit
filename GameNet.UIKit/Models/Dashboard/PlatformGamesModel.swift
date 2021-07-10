//
//  PlatformGamesModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct PlatformGameModel: Codable {
    var id: String
    var name: String
    var platformGamesTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "platformId"
        case name = "platformName"
        case platformGamesTotal
    }
}

struct PlatformGamesModel: Codable {
    var total: Int // Computar essa propriedade Platforms?.Sum(x => x.PlatformGamesTotal) ?? 0;
    var platforms: [PlatformGameModel]
    
    enum CodingKeys: String, CodingKey {
        case total
        case platforms
    }
}
