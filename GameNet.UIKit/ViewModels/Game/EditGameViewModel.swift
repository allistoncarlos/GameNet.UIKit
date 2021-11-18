//
//  EditGameViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 19/10/21.
//

import Foundation

protocol EditGameViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var renderPlatformsData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }
    
    var apiResult: APIResult<GameModel>? { get set }
    var platformsResult: APIResult<PagedResult<PlatformModel>>? { get set }
    
    func fetchData(id: String)
    func fetchPlatforms()
    func save(data: GameEditModel)
}

class EditGameViewModel: ObservableObject, EditGameViewModelProtocol {
    private var service: ServiceBox<GameService>?
    private var platformsService: ServiceBox<PlatformService>?
    
    var apiResult: APIResult<GameModel>? {
        didSet {
            renderData?()
        }
    }
    
    var platformsResult: APIResult<PagedResult<PlatformModel>>? {
        didSet {
            renderPlatformsData?()
        }
    }
    
    var renderData: (() -> Void)?
    var renderPlatformsData: (() -> Void)?
    var savedData: (() -> Void)?
    
    init(
        service: ServiceBox<GameService>?,
        platformsService: ServiceBox<PlatformService>?
    ) {
        self.service = service
        self.platformsService = platformsService
    }
    
    func fetchData(id: String) {
        service?.object.get(id: id, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchPlatforms() {
        platformsService?.object.load(page: nil, pageSize: nil, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.platformsResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func save(data: GameEditModel) {
        service?.object.save(model: data, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.savedData?()
            case .failure(let error):
                print(error)
            }
        })
    }
}
