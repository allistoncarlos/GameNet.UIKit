//
//  DashboardViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation
import GameNet_Network

protocol DashboardViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var result: Dashboard? { get set }

    func fetchData() async
}

final class DashboardViewModel: ObservableObject, DashboardViewModelProtocol {
    var renderData: (() -> Void)?

    var result: Dashboard? {
        didSet {
            renderData?()
        }
    }

    // MARK: - DashboardViewModelProtocol
    func fetchData() async {
        if let apiResult = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<DashboardResponse>.self,
                endpoint: .dashboard) {
            if apiResult.ok {
                self.result = apiResult.data.toDashboard()
            }
        }
    }
}
