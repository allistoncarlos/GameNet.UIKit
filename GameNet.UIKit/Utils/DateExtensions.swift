//
//  DateExtensions.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 03/08/21.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        
        return dateFormatter.string(from: self)
    }
}
