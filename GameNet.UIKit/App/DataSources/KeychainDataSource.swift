//
//  KeychainDataSource.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 08/04/22.
//

import Foundation
import KeychainAccess

enum KeychainDataSource: String {
    case id
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case expiresIn = "expires_in"

    private var keychain: Keychain {
        return Keychain(service: Constants.keychainIdentifier)
    }

    func set(_ str: String) {
        keychain[rawValue] = str
    }

    func get() -> String? {
        return keychain[rawValue]
    }

    func remove() {
        try? keychain.remove(rawValue)
    }

    static func hasValidToken() -> Bool {
        if id.get() != nil &&
            accessToken.get() != nil &&
            refreshToken.get() != nil,
           let expiresIn = expiresIn.get()?.toDate(),
           expiresIn > NSDate.init() as Date {
            return true
        }

        return false
    }
}
