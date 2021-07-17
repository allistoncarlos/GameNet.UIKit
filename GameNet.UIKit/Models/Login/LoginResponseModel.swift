//
//  LoginResponseModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation

struct LoginResponseModel: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var accessToken: String
    var refreshToken: String
    var expiresIn: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
}
