//
//  DateExtensions.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 03/08/21.
//

import Foundation

extension Date {
    func toFormattedString(dateFormat: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let dateFormat = dateFormat {
            dateFormatter.dateFormat = dateFormat
        } else {
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        
        return dateFormatter.date(from: self)
    }
}
