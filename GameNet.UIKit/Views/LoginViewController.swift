//
//  ViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import Swinject

class LoginViewController: UIViewController {
    // MARK: - Properties
    var presenter: UserPresenterProtocol?
    
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

        presenter?.login(username: username, password: password)
    }
}

extension LoginViewController: UserPresenterDelegate {
    
}

