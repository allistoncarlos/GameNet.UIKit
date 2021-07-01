//
//  PlatformsViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import UIKit

class PlatformsViewController: UITableViewController {
    // MARK: - Properties
    var presenter: PlatformPresenterProtocol?
    var platforms: [PlatformViewModel] = []
    var isLoading: Bool = false
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.platformsViewTitle
        
        self.isLoading = true
        presenter = PlatformPresenter(service: PlatformService(apiResource: Constants.platformResource), delegate: self)
        presenter?.load()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platforms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "platformViewCell")
        cell.textLabel?.text = platforms[indexPath.row].name
        return cell
    }
}

extension PlatformsViewController: PlatformPresenterDelegate {
    func render(platforms: [PlatformViewModel]) {
        self.platforms = platforms
        
        self.isLoading = false
        tableView.reloadData()
    }
}
