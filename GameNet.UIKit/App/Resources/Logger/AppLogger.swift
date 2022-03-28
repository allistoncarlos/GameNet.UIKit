//
//  AppLogger.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/03/22.
//

import Foundation
import Logging
import Pulse

struct AppLogger {
    static let log: Logger = {
        #if !PRODUCTION
            return Logger(label: Bundle.main.bundleIdentifier!, factory: PersistentLogHandler.init)
        #elseif PRODUCTION
            return Logger(label: Bundle.main.bundleIdentifier!)
        #endif
    }()
}
