//
//  RefreshTokenRequestModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/07/21.
//

import Foundation

struct RefreshTokenRequestModel: Codable {
    var accessToken: String
    var refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
