//
//  BoughtGamesByYearModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

struct BoughtGamesByYearTotalModel: Codable {
    var year: Int
    var total: Decimal
    var quantity: Int

    enum CodingKeys: String, CodingKey {
        case year
        case total
        case quantity
    }
}
