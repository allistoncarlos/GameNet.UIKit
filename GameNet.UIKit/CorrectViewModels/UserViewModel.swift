//
//  UserViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 07/10/21.
//

import Foundation

protocol UserViewModelProtocol: AnyObject {
    func login(username: String,
               password: String,
               completion: @escaping (Result<LoginResponseModel, Error>) -> Void
    )
}

final class UserViewModel: ObservableObject, UserViewModelProtocol {
    private var service: UserServiceProtocol?
    
    init(service: UserServiceProtocol?) {
        self.service = service
    }
    
    // MARK: - UserPresenterProtocol
    func login(username: String,
               password: String,
               completion: @escaping (Result<LoginResponseModel, Error>) -> Void
    ) {
        service?.login(loginRequestModel: LoginRequestModel(username: username, password: password))
        { (result) in
            switch result {
                case .success(let loginResult):
                    completion(.success(loginResult))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
