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
            .performRequestAsync(
                model: LoginResponseModel.self,
                endpoint: .login(loginRequestModel: LoginRequestModel(username: username, password: password)))
        return result
    }
}
