//
//  UserViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 07/10/21.
//

import Foundation

protocol UserViewModelProtocol: AnyObject {
    func login(username: String, password: String) async -> LoginResponseModel?
}

final class UserViewModel: ObservableObject, UserViewModelProtocol {
    func login(username: String, password: String) async -> LoginResponseModel? {
        let result = await NetworkManager.shared
            .performRequest(
                model: LoginResponseModel.self,
                endpoint: .login(loginRequestModel: LoginRequestModel(username: username, password: password)))

        self.saveToken(result: result)

        return result
    }

    private func saveToken(result: LoginResponseModel?) {
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
