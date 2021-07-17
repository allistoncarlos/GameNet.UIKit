//
//  DashboardViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import KeychainAccess

class DashboardViewController: UIViewController, UITableViewDataSource, UserPresenterDelegate {
    // MARK: - Outlets
    @IBOutlet weak var playingGamesView: UIView?
    @IBOutlet weak var playingGamesTableView: UITableView?
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.dashboardViewTitle
        playingGamesView?.layer.cornerRadius = 10
        
        
//        let keychain = Keychain(service: Constants.keychainIdentifier)
//
//        guard let accessToken = keychain[Constants.accessTokenIdentifier],
//              let refreshToken = keychain[Constants.refreshTokenIdentifier] else {
//            return
//        }
//
//        let userPresenter = UserPresenter(service: UserService(), delegate: self)
//        userPresenter.refreshToken(accessToken: accessToken, refreshToken: refreshToken)
        
        DashboardService(apiResource: "dashboard").get { (result) in
            switch result {
            case .success(let apiResult):
                print(apiResult)
                self.playingGamesTableView?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case playingGamesTableView:
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
