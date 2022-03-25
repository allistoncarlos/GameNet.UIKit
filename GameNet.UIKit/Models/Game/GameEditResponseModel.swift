//
//  GameEditResponseModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 18/11/21.
//

import Foundation

struct GameEditResponseModel: BaseModel {
    var id: String?
    var name: String
    var coverURL: String
    var platform: PlatformModel

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coverURL
        case platform
    }
}
