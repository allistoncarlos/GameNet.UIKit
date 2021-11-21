//
//  ListService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation

protocol ListServiceProtocol: ServiceProtocol {
    
}

class ListService: Service<ListModel>, ListServiceProtocol {
    typealias T = ListModel
}
