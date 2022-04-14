//
//  EditListViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/11/21.
//

import Foundation

protocol EditListViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: ListModel? { get set }

    func fetchData(id: String) async
    func save(id: String?, data: ListModel) async
}

class EditListViewModel: ObservableObject, EditListViewModelProtocol {
    var result: ListModel? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<ListModel>.self,
                endpoint: .list(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }

    func save(id: String?, data: ListModel) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<ListModel>.self,
                endpoint: .saveList(id: id, model: data)) {
            if apiResult.ok {
                self.result = apiResult.data
                self.savedData?()
            }
        }
    }
}
