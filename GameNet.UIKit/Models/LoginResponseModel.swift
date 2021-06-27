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
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case token
    }
}
