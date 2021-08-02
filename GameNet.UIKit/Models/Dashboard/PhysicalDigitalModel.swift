//
//  PhysicalDigitalModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct PhysicalDigitalModel: Codable {
    var physical: Int
    var digital: Int
    
    enum CodingKeys: String, CodingKey {
        case physical
        case digital
    }
}
