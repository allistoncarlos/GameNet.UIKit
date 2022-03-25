//
//  PlatformService.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import Foundation

protocol PlatformServiceProtocol: ServiceProtocol {

}

class PlatformService: Service<PlatformModel>, PlatformServiceProtocol {
    typealias T = PlatformModel
}
