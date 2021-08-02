//
//  PlatformModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct PlatformModel: BaseModel {
    var id: String?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
