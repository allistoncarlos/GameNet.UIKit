//
//  UserPresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation
import KeychainAccess

protocol UserPresenterProtocol: AnyObject {
    func login(username: String, password: String)
    func hasValidToken() -> Bool
}

protocol UserPresenterDelegate: AnyObject {
    
}

class UserPresenter: UserPresenterProtocol {
    private var service: UserServiceProtocol
    private weak var delegate: UserPresenterDelegate?
    
    init(service: UserServiceProtocol, delegate: UserPresenterDelegate?) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - UserPresenterProtocol
    func login(username: String, password: String) {
        service.login(LoginRequestModel: LoginRequestModel(username: username, password: password))
        { (result) in
            switch result {
                case .success(let user):
                    self.saveToken(token: user.token)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func hasValidToken() -> Bool {
        let keychain = Keychain(service: Constants.keychainIdentifier)
        if keychain[Constants.tokenIdentifier] != nil {
            return true
        }
        
        return false
    }
    
    // MARK: - Private funcs
    private func saveToken(token: String) {
        let keychain = Keychain(service: Constants.keychainIdentifier)
        keychain[Constants.tokenIdentifier] = token
    }
}
