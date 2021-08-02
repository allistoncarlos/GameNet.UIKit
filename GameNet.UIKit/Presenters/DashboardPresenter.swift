//
//  DashboardPresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 25/07/21.
//

import Foundation
import KeychainAccess
import Swinject

protocol DashboardPresenterProtocol: AnyObject {
    func fetchData()
}

protocol DashboardPresenterDelegate: AnyObject {
    func render(data: DashboardModel)
    func render(error: Error)
    func render(errors: [String])
}

class DashboardPresenter: DashboardPresenterProtocol {
    private var service: ServiceBox<DashboardService>?
    private weak var delegate: DashboardPresenterDelegate?

    init(delegate: DashboardPresenterDelegate?, service: ServiceBox<DashboardService>?) {
        self.delegate = delegate
        self.service = service
    }
    
    // MARK: - DashboardPresenterProtocol
    func fetchData() {
        service?.object.get { (result) in
            switch result {
            case .success(let apiResult):
                if (apiResult.ok) {
                    self.delegate?.render(data: apiResult.data)
                }
                else {
                    self.delegate?.render(errors: apiResult.errors)
                }
            case .failure(let error):
                self.delegate?.render(error: error)
            }
        }
    }
}
