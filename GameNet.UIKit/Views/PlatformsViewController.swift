//
//  PlatformsViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import UIKit
import Swinject

class PlatformsViewController: UITableViewController {
    // MARK: - Properties
    var presenter: PlatformPresenterProtocol?
    var platforms: [PlatformViewModel] = []
    var isLoading: Bool = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.platformsViewTitle
        
        self.isLoading = true
        presenter?.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let statusBarFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = Constants.primaryColor
        view.addSubview(statusBarView)
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
