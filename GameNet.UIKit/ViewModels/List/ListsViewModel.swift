//
//  ListsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation

protocol ListsViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: [ListModel]? { get set }

    func fetchData() async
}

class ListsViewModel: ObservableObject, ListsViewModelProtocol {
    private var service: ListServiceProtocol?

    var result: [ListModel]? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?

    // MARK: - ListsViewModelProtocol
    func fetchData() async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<ListModel>>.self,
                endpoint: .lists) {
            if apiResult.ok {
                self.result = apiResult.data.result
            }
        }
    }
}
