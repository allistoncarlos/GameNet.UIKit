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
    }

    // MARK: - IBActions
    @IBAction func loginTouched(_ sender: Any) {
        guard let username = usernameTextField?.text else { return }
        guard let password = passwordTextField?.text else { return }

        loginButton?.isEnabled = false

        Task {
            if await viewModel?.login(username: username, password: password) != nil {
                self.loggedIn()
            } else {
                self.loginButton?.isEnabled = true
            }
        }
    }
}

extension LoginViewController {
    func loggedIn() {
        self.coordinator?.loggedIn()
    }
}

#if DEBUG
import SwiftUI

struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // leave this empty
    }

    func makeUIViewController(context: Context) -> UIViewController {
        LoginViewController.instantiate()!
    }
}

struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
       LoginViewControllerRepresentable()
            .preferredColorScheme(.dark)
    }
}
#endif
