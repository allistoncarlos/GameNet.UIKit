//
//  PlatformsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 11/10/21.
//

import Foundation
import GameNet_Network

protocol PlatformsViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: [Platform] { get set }

    func fetchData() async
}

final class PlatformsViewModel: ObservableObject, PlatformsViewModelProtocol {
    var result: [Platform] = [Platform]() {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?

    // MARK: - PlatformsViewModelProtocol
    func fetchData() async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PagedResult<PlatformResponse>>.self,
                endpoint: .platforms) {
            if apiResult.ok {
                self.result = apiResult.data.result.compactMap { $0.toPlatform() }
            }
        }
    }
}
