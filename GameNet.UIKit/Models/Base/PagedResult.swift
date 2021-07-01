//
//  PagedResult.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import Foundation

struct PagedResult<T: Codable>: Codable {
    var count: Int
    var totalCount: Int
    var page: Int?
    var pageSize: Int?
    var search: String?
    var result: Array<T>
    
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case totalCount
        case page
        case pageSize
        case search
        case result
        
        case totalPages
    }
}
