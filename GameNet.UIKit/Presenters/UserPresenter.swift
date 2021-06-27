//
//  UserPresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation

protocol UserPresenterProtocol: AnyObject {
    func login(username: String, password: String)
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
                    print(user)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private funcs
    private func saveToken() {
        
    }
}
