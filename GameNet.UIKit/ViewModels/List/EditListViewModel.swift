//
//  EditListViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/11/21.
//

import Foundation
import GameNet_Network

protocol EditListViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: List? { get set }

    func fetchData(id: String) async
    func save(id: String?, data: List) async
}

class EditListViewModel: ObservableObject, EditListViewModelProtocol {
    var result: List? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<ListResponse>.self,
                endpoint: .list(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data.toList()
            }
        }
    }

    func save(id: String?, data: List) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<ListResponse>.self,
                endpoint: .saveList(id: id, data: data.toRequest())) {
            if apiResult.ok {
                self.result = apiResult.data.toList()
                self.savedData?()
            }
        }
    }
}
