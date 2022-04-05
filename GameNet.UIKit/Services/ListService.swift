//
//  ListService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation
import Alamofire

protocol ListServiceProtocol: AnyObject {
    func getLists(page: Int?,
                  pageSize: Int?,
                  search: String?,
                  completion: @escaping (Result<APIResult<PagedResult<ListModel>>, Error>) -> Void)
    func getFinishedByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void)
    func getBoughtByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void)
    func getCustomList(id: String, completion: @escaping (Result<APIResult<ListGameModel>, Error>) -> Void)
}

class ListService: Service<ListModel>, ListServiceProtocol {
    typealias T = ListModel

    func getLists(page: Int? = nil,
                  pageSize: Int? = nil,
                  search: String? = nil,
                  completion: @escaping (Result<APIResult<PagedResult<ListModel>>, Error>) -> Void) {
        load(page: page, pageSize: pageSize, search: search, completion: completion)
    }

    func getFinishedByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void) {
        let relativeUrl = "/FinishedByYear/\(id)"
        get(relativeUrl: relativeUrl, completion: completion)
    }

    func getBoughtByYear(id: String, completion: @escaping (Result<APIResult<[ListItemModel]>, Error>) -> Void) {
        let relativeUrl = "/BoughtByYear/\(id)"
        get(relativeUrl: relativeUrl, completion: completion)
    }

    func getCustomList(id: String, completion: @escaping (Result<APIResult<ListGameModel>, Error>) -> Void) {
        let relativeUrl = "/\(id)"
        get(relativeUrl: relativeUrl, completion: completion)
    }
}
