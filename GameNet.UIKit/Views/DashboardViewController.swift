//
//  DashboardViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit

class DashboardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.dashboardViewTitle
        
        DashboardService(apiResource: "dashboard").get { (result) in
            switch result {
            case .success(let apiResult):
                print(apiResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
