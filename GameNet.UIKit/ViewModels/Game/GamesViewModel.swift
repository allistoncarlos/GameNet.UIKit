//
//  GamesViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 15/10/21.
//

import Foundation

protocol GamesViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: GameModel? { get set }
    var pagedResult: PagedResult<GameModel>? { get set }
    var data: [GameModel] { get set }
    var searchedGames: [GameModel] { get set }

    var isLoading: Bool { get set }

    func fetchData() async
    func fetchData(id: String) async
    func fetchData(search: String?, page: Int) async
}

class GamesViewModel: ObservableObject, GamesViewModelProtocol {
    var result: GameModel?
    
    var pagedResult: PagedResult<GameModel>? {
        didSet {
            if let pagedResult = pagedResult {
                self.data += pagedResult.result
            }

            renderData?()
        }
    }

    var data: [GameModel] = []
    var searchedGames: [GameModel] = []
    var isLoading: Bool = false

    var renderData: (() -> Void)?

    // MARK: - GamesViewModelProtocol
    func fetchData() async {
        await self.fetchData(search: nil, page: 0)
    }
    
    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<GameModel>.self,
                endpoint: .game(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }

    func fetchData(search: String?, page: Int) async {
        self.isLoading = true

        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<GameModel>>.self,
                endpoint: .games(search: search, page: page, pageSize: Constants.pageSize)) {
            self.isLoading = false

            if apiResult.ok {
                self.pagedResult = apiResult.data
            }
        }
    }
}
