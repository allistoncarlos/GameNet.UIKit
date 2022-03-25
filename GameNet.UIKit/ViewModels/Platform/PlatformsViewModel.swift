//
//  PlatformsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 11/10/21.
//

import Foundation

protocol PlatformsViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var apiResult: APIResult<PagedResult<PlatformModel>>? { get set }

    func fetchData()
}

class PlatformsViewModel: ObservableObject, PlatformsViewModelProtocol {
    private var service: ServiceBox<PlatformService>?

    var apiResult: APIResult<PagedResult<PlatformModel>>? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?

    init(service: ServiceBox<PlatformService>?) {
        self.service = service
    }

    // MARK: - PlatformsViewModelProtocol
    func fetchData() {
        service?.object.load(page: nil, pageSize: nil, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
