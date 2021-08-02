//
//  PlatformPresenter.swift
//  PlatformNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

protocol PlatformPresenterProtocol: AnyObject {
    func load()
}

protocol PlatformPresenterDelegate: AnyObject {
    func render(platforms: [PlatformViewModel])
}

class PlatformPresenter: PlatformPresenterProtocol {
    private var service: ServiceBox<PlatformService>?
    private weak var delegate: PlatformPresenterDelegate?
    private var apiResult: APIResult<PagedResult<PlatformModel>>?
    private var platforms: [PlatformViewModel] = []

    init(delegate: PlatformPresenterDelegate?, service: ServiceBox<PlatformService>?) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - PlatformPresenterProtocol
    func load() {
        service?.object.load(page: nil, pageSize: nil, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
                
                if apiResult.ok {
                    self.platforms = self.mapToViewModel(apiResult.data.result)
                }
                
                self.delegate?.render(platforms: self.platforms)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Private funcs
    private func mapToViewModel(_ platforms: [PlatformModel]) -> [PlatformViewModel] {
        return platforms.map { platform in
            PlatformViewModel(id: platform.id!, name: platform.name)
        }
    }
}
