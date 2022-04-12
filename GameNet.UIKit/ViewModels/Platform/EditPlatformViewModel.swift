//
//  EditPlatformViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/10/21.
//

import Foundation

protocol EditPlatformViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var result: PlatformModel? { get set }

    func fetchData(id: String) async
    func save(id: String?, data: PlatformModel) async
}

class EditPlatformViewModel: ObservableObject, EditPlatformViewModelProtocol {
    var result: PlatformModel? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    func fetchData(id: String) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<PlatformModel>.self,
                endpoint: .platform(id: id)) {
            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }

    func save(id: String?, data: PlatformModel) async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<PlatformModel>.self,
                endpoint: .savePlatform(id: id, model: data)) {
            if apiResult.ok {
                self.savedData?()
            }
        }
    }
}
