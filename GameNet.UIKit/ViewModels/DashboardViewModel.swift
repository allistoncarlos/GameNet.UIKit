//
//  DashboardViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation

protocol DashboardViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: DashboardModel? { get set }

    func fetchData() async
}

final class DashboardViewModel: ObservableObject, DashboardViewModelProtocol {
    var renderData: (() -> Void)?
    
    var result: DashboardModel? {
        didSet {
            renderData?()
        }
    }

    // MARK: - DashboardViewModelProtocol
    func fetchData() async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                model: APIResult<DashboardModel>.self,
                endpoint: .dashboard) {
            if apiResult.ok {
                self.result = apiResult.data
            }
        }
    }
}
