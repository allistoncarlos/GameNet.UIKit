//
//  FinishedGameByYearTotalModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct FinishedGameByYearTotalModel: Codable {
    var year: Int
    var total: Int
    
    enum CodingKeys: String, CodingKey {
        case year
        case total
    }
}
