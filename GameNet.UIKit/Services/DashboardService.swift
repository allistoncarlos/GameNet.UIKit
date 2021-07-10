//
//  DashboardService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

protocol DashboardServiceProtocol: ServiceProtocol {
    
}

class DashboardService: Service<DashboardModel>, DashboardServiceProtocol {
    typealias T = DashboardModel
}
