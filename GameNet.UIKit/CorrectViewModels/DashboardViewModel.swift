//
//  DashboardViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation

protocol DashboardViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var apiResult: APIResult<DashboardModel>? { get set }
    
    func fetchData()
}

class DashboardViewModel: ObservableObject, DashboardViewModelProtocol {
    private var service: ServiceBox<DashboardService>?
    
    var apiResult: APIResult<DashboardModel>? {
        didSet {
            renderData?()
        }
    }
    
    var renderData: (() -> Void)?
    
    init(service: ServiceBox<DashboardService>?) {
        self.service = service
    }
    
    // MARK: - PlatformsViewModelProtocol
    func fetchData() {
        service?.object.get { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
