//
//  ListDetailViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/03/22.
//

import Foundation
import GameNet_Network

protocol ListDetailViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: [ListItem]? { get set }
    var listType: ListType { get set }

    func fetchData(id: String) async
}

class ListDetailViewModel: ObservableObject, ListDetailViewModelProtocol {
    var result: [ListItem]? {
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
                responseType: APIResult<[ListItemResponse]>.self,
                endpoint: .finishedByYearList(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data.compactMap { $0.toListItem() }
            }
        }
    }

    private func fetchBoughtByYearData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<[ListItemResponse]>.self,
                endpoint: .boughtByYearList(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data.compactMap { $0.toListItem() }
            }
        }
    }

    private func fetchCustomListData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<ListGameResponse>.self,
                endpoint: .list(id: id)) {
            if apiResult.ok,
               let games = apiResult.data.games {
                self.result = games.compactMap { $0.toListItem() }
            }
        }
    }
}
