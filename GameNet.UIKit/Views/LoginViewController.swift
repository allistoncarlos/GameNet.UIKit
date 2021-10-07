//
//  ViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import Swinject

class LoginViewController: UIViewController {
    // MARK: - Static Properties
    static let NotificationLoggedIn = NSNotification.Name(rawValue: "LoggedIn")
    
    // MARK: - Properties
    var viewModel: UserViewModelProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func loginTouched(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }

//        viewModel?.login(username: username, password: password)
        viewModel?.login(username: username, password: password, completion: {
            (result) in
            switch result {
            case .success(_):
                self.loggedIn()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension LoginViewController {
    func loggedIn() {
        NotificationCenter.default.post(name: LoginViewController.NotificationLoggedIn, object: nil)
    }
}

