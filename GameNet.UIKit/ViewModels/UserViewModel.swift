//
//  UserViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 07/10/21.
//

import Foundation
import GameNet_Network
import GameNet_Keychain

protocol UserViewModelProtocol: AnyObject {
    func login(username: String, password: String) async -> LoginResponse?
}

final class UserViewModel: ObservableObject, UserViewModelProtocol {
    func login(username: String, password: String) async -> LoginResponse? {
        let result = await NetworkManager.shared
            .performRequest(
                responseType: LoginResponse.self,
                endpoint: .login(data: LoginRequest(username: username, password: password)))

        self.saveToken(result: result)

        return result
    }

    private func saveToken(result: LoginResponse?) {
        if let session = result {
            let dateFormatter = ISO8601DateFormatter()

            KeychainDataSource.id.set(session.id)
            KeychainDataSource.accessToken.set(session.accessToken)
            KeychainDataSource.refreshToken.set(session.refreshToken)
            KeychainDataSource.expiresIn.set(dateFormatter.string(from: session.expiresIn))
        } else {
            KeychainDataSource.clear()
        }
    }
}
