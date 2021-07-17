//
//  RefreshTokenResponseModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/07/21.
//

import Foundation

struct RefreshTokenResponseModel: Codable {
    var accessToken: String
    var refreshToken: String
    var expiresIn: Date
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
}
