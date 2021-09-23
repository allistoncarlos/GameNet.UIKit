//
//  GameplayModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/09/21.
//

import Foundation

struct GameplayModel: Codable {
    var start: Date
    var finish: Date?
    
    enum CodingKeys: String, CodingKey {
        case start
        case finish
    }
}
