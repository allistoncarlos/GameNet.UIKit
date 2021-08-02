//
//  DashboardViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import KeychainAccess

class DashboardViewController: UIViewController, UITableViewDataSource {
    // MARK: - Properties
    var presenter: DashboardPresenterProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var playingGamesView: UIView?
    @IBOutlet weak var playingGamesTableView: UITableView?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.dashboardViewTitle
        playingGamesView?.layer.cornerRadius = 10
        
        presenter?.fetchData()
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

extension DashboardViewController: DashboardPresenterDelegate {
    func renderLoading() {
        
    }
    
    func render(data: DashboardModel) {
        print("DATA FETCHED")
    }
    
    func render(error: Error) {
        
    }
    
    func render(errors: [String]) {
        
    }
}
