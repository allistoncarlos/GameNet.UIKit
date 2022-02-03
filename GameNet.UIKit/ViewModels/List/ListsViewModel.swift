//
//  ListsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 21/11/21.
//

import Foundation

protocol ListsViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var apiResult: APIResult<PagedResult<ListModel>>? { get set }
    
    func fetchData()
}

class ListsViewModel: ObservableObject, ListsViewModelProtocol {
    private var service: ServiceBox<ListService>?
    
    var apiResult: APIResult<PagedResult<ListModel>>? {
        didSet {
            renderData?()
        }
    }
    
    var renderData: (() -> Void)?
    
    init(service: ServiceBox<ListService>?) {
        self.service = service
    }
    
    // MARK: - ListsViewModelProtocol
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
