//
//  ViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTouched(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }
        
        let loginModel = LoginRequestModel(username: username, password: password)
        UserService().login(LoginRequestModel: loginModel) { result in
            switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}

