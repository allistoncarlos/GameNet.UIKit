//
//  GamePresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/06/21.
//

import Foundation

protocol GamePresenterProtocol: AnyObject {
    func load()
    func load(page: Int)
}

protocol GamePresenterDelegate: AnyObject {
    func render(pagedResult: PagedResultViewModel<GameViewModel>?)
}

class GamePresenter: GamePresenterProtocol {
    private var service: GameService
    private weak var delegate: GamePresenterDelegate?
    private var apiResult: APIResult<PagedResult<GameModel>>?
    private var pagedResultViewModel: PagedResultViewModel<GameViewModel>?

    init(service: GameService, delegate: GamePresenterDelegate?) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - GamePresenterProtocol
    func load() {
        self.load(page: 1)
    }
    
    func load(page: Int) {
        service.load(page: page, pageSize: Constants.pageSize, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
                
                if apiResult.ok {
                    self.pagedResultViewModel = self.mapToViewModel(apiResult.data)
                }
                
                self.delegate?.render(pagedResult: self.pagedResultViewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Private funcs
    private func mapToViewModel(_ pagedResult: PagedResult<GameModel>) -> PagedResultViewModel<GameViewModel> {
        let data = pagedResult.result.map { game in
            GameViewModel(id: game.id, name: game.name, cover: game.cover, platformId: game.platformId, platform: game.platform)
        }
        
        let pagedResultViewModel = PagedResultViewModel<GameViewModel>(
            count: pagedResult.count,
            totalCount: pagedResult.totalCount,
            page: pagedResult.page,
            pageSize: pagedResult.pageSize,
            search: pagedResult.search,
            result: data,
            totalPages: pagedResult.totalPages)
        
        return pagedResultViewModel
    }
}
