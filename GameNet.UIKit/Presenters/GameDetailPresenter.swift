//
//  GameDetailPresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/08/21.
//

import Foundation

protocol GameDetailPresenterProtocol: AnyObject {
    func get(id: String)
}

protocol GameDetailPresenterDelegate: AnyObject {
    func render(result: GameDetailViewModel?)
}

class GameDetailPresenter: GameDetailPresenterProtocol {
    private var service: ServiceBox<GameService>?
    private weak var delegate: GameDetailPresenterDelegate?

    init(delegate: GameDetailPresenterDelegate?, service: ServiceBox<GameService>?) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - GamePresenterProtocol
    func get(id: String) {
        service?.object.getGameDetail(id: id, completion: { (result) in
            switch result {
                case .success(let apiResult):
                    if apiResult.ok {
                        let viewModel = self.mapToViewModel(apiResult.data)
                        self.delegate?.render(result: viewModel)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Private funcs
    private func mapToViewModel(_ apiResult: GameDetailModel) -> GameDetailViewModel {
        let viewModel = GameDetailViewModel(
            id: apiResult.id!,
            name: apiResult.name,
            cover: apiResult.cover,
            platform: apiResult.platform,
            value: apiResult.value,
            boughtDate: apiResult.boughtDate
        )
        
        return viewModel
    }
}
