//
//  ListDetailViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/03/22.
//

import Foundation

protocol ListDetailViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: [ListItemModel]? { get set }
    var listType: ListType { get set }

    func fetchData(id: String) async
}

class ListDetailViewModel: ObservableObject, ListDetailViewModelProtocol {
    private var service: ListServiceProtocol?

    var result: [ListItemModel]? {
        didSet {
            renderData?()
        }
    }

    var listType: ListType = .custom

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    func fetchData(id: String) async {
        switch listType {
        case .finishedByYear:
            await fetchFinishedByYearData(id: id)
        case .boughtByYear:
            await fetchBoughtByYearData(id: id)
        case .custom:
            await fetchCustomListData(id: id)
        }
    }

    private func fetchFinishedByYearData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<[ListItemModel]>.self,
                endpoint: .finishedByYearList(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }

    private func fetchBoughtByYearData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<[ListItemModel]>.self,
                endpoint: .boughtByYearList(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }

    private func fetchCustomListData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<ListGameModel>.self,
                endpoint: .list(id: id)) {
            if apiResult.ok,
               let games = apiResult.data.games {
                self.result = games
            }
        }
    }
}
