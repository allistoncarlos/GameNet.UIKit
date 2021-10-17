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
    
    var apiResult: APIResult<PlatformModel>? { get set }
    
    func fetchData(id: String)
    func save(id: String?, data: PlatformModel)
}

class EditPlatformViewModel: ObservableObject, EditPlatformViewModelProtocol {
    private var service: ServiceBox<PlatformService>?
    
    var apiResult: APIResult<PlatformModel>? {
        didSet {
            renderData?()
        }
    }
    
    var renderData: (() -> Void)?
    var savedData: (() -> Void)?
    
    init(service: ServiceBox<PlatformService>?) {
        self.service = service
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
    
    func save(id: String?, data: PlatformModel) {
        service?.object.save(id: id, model: data, completion: { (result) in
            switch result {
            case .success(_):
                self.savedData!()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
