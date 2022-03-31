//
//  FontExtensions.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 03/08/21.
//

import UIKit

extension UIFont {
    // MARK: - Dashboard
    static var dashboardPlayingGameTitle: UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: 20)!
    }

    static var dashboardPlayingGameSubtitle: UIFont {
        return UIFont(name: "AvenirNext-Regular", size: 15)!
    }

    // MARK: - ListItemCell
    static var listItemCellGameName: UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: 24)!
    }

    static var listItemCellPlatform: UIFont {
        return UIFont(name: "AvenirNext-DemiBold", size: 18)!
    }

    static var listItemCellDetail: UIFont {
        return UIFont(name: "AvenirNext-Regular", size: 16)!
    }
}
