//
//  UserPresenter.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import Foundation
import KeychainAccess
import Swinject

protocol UserPresenterProtocol: AnyObject {
    func login(username: String, password: String)
}

protocol UserPresenterDelegate: AnyObject {
    
}

class UserPresenter: UserPresenterProtocol {
    private var service: UserServiceProtocol?
    private weak var delegate: UserPresenterDelegate?
    
    init(delegate: UserPresenterDelegate?,
         service: UserServiceProtocol?) {
        self.delegate = delegate
        self.service = service
    }
    
    // MARK: - UserPresenterProtocol
    func login(username: String, password: String) {
        service?.login(loginRequestModel: LoginRequestModel(username: username, password: password))
        { (result) in
            switch result {
                case .success(let user):
                    print(user)
                    print("CHAMAR O DELEGATE DO SEGUE")
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
