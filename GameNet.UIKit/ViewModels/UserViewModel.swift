//
//  UserViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 07/10/21.
//

import Foundation

protocol UserViewModelProtocol: AnyObject {
    var loggedIn: (() -> Void)? { get set }
    func login(username: String, password: String)
}

final class UserViewModel: ObservableObject, UserViewModelProtocol {
    private var service: UserServiceProtocol?
    
    var loggedIn: (() -> Void)?
    
    init(service: UserServiceProtocol?) {
        self.service = service
    }
    
    // MARK: - UserViewModelProtocol
    func login(username: String, password: String) {
        service?.login(loginRequestModel: LoginRequestModel(username: username, password: password))
        { (result) in
            switch result {
            case .success(_):
                self.loggedIn?()
            case .failure(_):
                print(result)
            }
        }
    }
}
