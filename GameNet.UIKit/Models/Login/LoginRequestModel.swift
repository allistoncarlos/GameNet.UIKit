//
//  LoginRequestModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation

struct LoginRequestModel: Codable {
    var username: String
    var password: String

    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
