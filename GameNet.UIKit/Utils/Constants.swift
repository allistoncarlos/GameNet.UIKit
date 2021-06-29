//
//  Constants.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation
import UIKit

class Constants {
    static let apiPath = "https://gamenet.azurewebsites.net/api"
    static let userResource = "user"
    static let gameResource = "usergame"
    
    static let keychainIdentifier = "gamenet.azurewebsites.net"
    static let tokenIdentifier = "token"
    
    static let dashboardViewTitle = "Dashboard"
    static let gamesViewTitle = "Games"
    
    static let pageSizePhone = 21
    static let pageSizePad = 30
    
    static let pageSize = UIDevice.current.userInterfaceIdiom == .phone ? pageSizePhone : pageSizePad
}
