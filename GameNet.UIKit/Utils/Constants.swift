//
//  Constants.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation
import UIKit

class Constants {
    static let apiPath = Bundle.main.infoDictionary!["API_PATH"]!
    static let userResource = "user"
    static let dashboardResource = "dashboard"
    static let gameResource = "usergame"
    static let gameplaySessionResource = "gameplaysession"
    static let platformResource = "platform"
    static let listResource = "list"
    
    static let keychainIdentifier = "gamenet.azurewebsites.net"
    static let userIdIdentifier = "id"
    static let accessTokenIdentifier = "access_token"
    static let refreshTokenIdentifier = "refresh_token"
    static let expiresInIdentifier = "expires_in"
    
    static let dashboardViewTitle = "Dashboard"
    static let gamesViewTitle = "Games"
    static let editGameViewTitle = "Novo Game"
    static let platformsViewTitle = "Plataformas"
    static let editPlatformViewTitle = "Nova Plataforma"
    static let listsViewTitle = "Listas"
    
    static let dateFormat = "dd/MM/yyyy HH:mm"
    
    static let pageSizePhone = 21
    static let pageSizePad = 30
    
    static let primaryColor = UIColor(red: 0.48, green: 0.12, blue: 0.64, alpha: 1.00)
    
    static let pageSize = UIDevice.current.userInterfaceIdiom == .phone ? pageSizePhone : pageSizePad
}
