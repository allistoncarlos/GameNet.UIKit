//
//  ViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import Swinject

class LoginViewController: UIViewController, StoryboardCoordinated {
    // MARK: - Properties
    var coordinator: LoginCoordinator?
    var viewModel: UserViewModelProtocol?

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var loginButton: UIButton?

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.loggedIn = { [weak self] in
            DispatchQueue.main.async {
                self?.loggedIn()
            }
        }

        viewModel?.loginFailed = { [weak self] in
            self?.loginButton?.isEnabled = true
        }
    }

    // MARK: - IBActions
    @IBAction func loginTouched(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }

        loginButton?.isEnabled = false

        viewModel?.login(username: username, password: password)
    }
}

extension LoginViewController {
    func loggedIn() {
        self.coordinator?.loggedIn()
    }
}
