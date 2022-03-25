//
//  GamesViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 15/10/21.
//

import Foundation

protocol GamesViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var apiResult: APIResult<PagedResult<GameModel>>? { get set }
    var data: [GameModel] { get set }
    var searchedGames: [GameModel] { get set }

    var isLoading: Bool { get set }

    func fetchData()
    func fetchData(search: String?, page: Int)
}

class GamesViewModel: ObservableObject, GamesViewModelProtocol {
    private var service: ServiceBox<GameService>?

    var apiResult: APIResult<PagedResult<GameModel>>? {
        didSet {
            if let pagedResult = apiResult?.data {
                self.data += pagedResult.result
            }

            renderData?()
        }
    }

    var data: [GameModel] = []
    var searchedGames: [GameModel] = []
    var isLoading: Bool = false

    var renderData: (() -> Void)?

    init(service: ServiceBox<GameService>?) {
        self.service = service
    }

    // MARK: - GamesViewModelProtocol
    func fetchData() {
        self.fetchData(search: nil, page: 0)
    }

    func fetchData(search: String?, page: Int) {
        self.isLoading = true

        service?.object.load(page: page, pageSize: Constants.pageSize, search: search, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.isLoading = false
                self.apiResult = apiResult
            case .failure(let error):
                self.isLoading = false
                print(error.localizedDescription)
            }
        })
    }
}
