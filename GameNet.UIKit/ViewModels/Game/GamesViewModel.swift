//
//  GamesViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 15/10/21.
//

import Foundation
import GameNet_Network

protocol GamesViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: Game? { get set }
    var pagedList: PagedList<Game>? { get set }
    var data: [Game] { get set }
    var searchedGames: [Game] { get set }

    var isLoading: Bool { get set }

    func fetchData() async
    func fetchData(id: String) async
    func fetchData(search: String?, page: Int) async
}

class GamesViewModel: ObservableObject, GamesViewModelProtocol {
    var result: Game?

    var pagedList: PagedList<Game>? {
        didSet {
            if let pagedList = pagedList {
                self.data += pagedList.result
            }

            renderData?()
        }
    }

    var data: [Game] = []
    var searchedGames: [Game] = []
    var isLoading: Bool = false

    var renderData: (() -> Void)?

    // MARK: - GamesViewModelProtocol

    func fetchData() async {
        await self.fetchData(search: nil, page: 0)
    }

    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<GameResponse>.self,
                endpoint: .game(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data.toGame()
            }
        }
    }

    func fetchData(search: String?, page: Int) async {
        self.isLoading = true

        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PagedResult<GameResponse>>.self,
                endpoint: .games(search: search, page: page, pageSize: Constants.pageSize)) {
            self.isLoading = false

            if apiResult.ok {
                let pagedResult = apiResult.data

                self.pagedList = PagedList<Game>(count: pagedResult.count,
                                                 totalCount: pagedResult.totalCount,
                                                 page: pagedResult.page,
                                                 pageSize: pagedResult.pageSize,
                                                 totalPages: pagedResult.totalPages,
                                                 search: pagedResult.search,
                                                 result: pagedResult.result.compactMap { $0.toGame() })
            }
        }
    }
}
