//
//  APIResult.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation

struct APIResult<T: Codable>: Codable {
    var ok: Bool
    var errors: [String]
    var data: T

    enum CodingKeys: String, CodingKey {
        case ok
        case errors
        case data
    }
    
    static func create(data: T) -> APIResult<T> {
        let result = APIResult<T>.init(ok: true, errors: [], data: data)
        return result
    }
}
