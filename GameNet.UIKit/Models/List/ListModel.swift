//
//  ListModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation

struct ListModel: BaseModel {
    var id: String?
    var name: String?
    var creationDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case creationDate
    }
}
