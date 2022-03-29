//
//  ListService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation
import Alamofire

protocol ListServiceProtocol: AnyObject {
    func getFinishedByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void)
    func getBoughtByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void)
}

class ListService: Service<ListModel>, ListServiceProtocol {
    typealias T = ListModel

    func getFinishedByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void) {
        let relativeUrl = "/FinishedByYear/\(id)"
        get(relativeUrl: relativeUrl, completion: completion)
    }

    func getBoughtByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void) {
        let relativeUrl = "/BoughtByYear/\(id)"
        get(relativeUrl: relativeUrl, completion: completion)
    }
}
