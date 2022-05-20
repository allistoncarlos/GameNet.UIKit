//
//  ListsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation
import GameNet_Network

protocol ListsViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: [List]? { get set }

    func fetchData() async
}

class ListsViewModel: ObservableObject, ListsViewModelProtocol {
    var result: [List]? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?

    // MARK: - ListsViewModelProtocol
    func fetchData() async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PagedResult<ListResponse>>.self,
                endpoint: .lists) {
            if apiResult.ok {
                self.result = apiResult.data.result.compactMap { $0.toList() }
            }
        }
    }
}
