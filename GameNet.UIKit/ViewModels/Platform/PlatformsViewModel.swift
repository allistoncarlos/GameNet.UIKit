//
//  PlatformsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 11/10/21.
//

import Foundation

protocol PlatformsViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: [PlatformModel] { get set }

    func fetchData() async
}

final class PlatformsViewModel: ObservableObject, PlatformsViewModelProtocol {
    var result: [PlatformModel] = [PlatformModel]() {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?

    // MARK: - PlatformsViewModelProtocol
    func fetchData() async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<PlatformModel>>.self,
                endpoint: .platforms) {
            if apiResult.ok {
                self.result = apiResult.data.result
            }
        }
    }
}
