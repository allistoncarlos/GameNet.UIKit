//
//  EditPlatformViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/10/21.
//

import Foundation
import GameNet_Network

protocol EditPlatformViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: Platform? { get set }

    func fetchData(id: String) async
    func save(id: String?, data: Platform) async
}

class EditPlatformViewModel: ObservableObject, EditPlatformViewModelProtocol {
    var result: Platform? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PlatformResponse>.self,
                endpoint: .platform(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data.toPlatform()
            }
        }
    }

    func save(id: String?, data: Platform) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<PlatformResponse>.self,
                endpoint: .savePlatform(id: id, data: data.toRequest())) {
            if apiResult.ok {
                self.result = apiResult.data.toPlatform()
                self.savedData?()
            }
        }
    }
}
