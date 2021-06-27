//
//  ViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var presenter: UserPresenterProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = UserPresenter(service: UserService(), delegate: self)
        
        if let presenter = presenter {
            if presenter.hasValidToken() {
                print("TÁ VÁLIDO")
            }
            else {
                print("LOGA AI MALANDRO")
            }
        }
    }

    // MARK: - IBActions
    @IBAction func loginTouched(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }

        presenter?.login(username: username, password: password)
    }
}

extension ViewController: UserPresenterDelegate {
    
}

