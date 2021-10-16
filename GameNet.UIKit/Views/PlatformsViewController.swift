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
    var viewModel: PlatformsViewModelProtocol?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.platformsViewTitle
        
        viewModel?.renderData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let statusBarFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = Constants.primaryColor
        view.addSubview(statusBarView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0

        if let apiResult = viewModel?.apiResult {
            if apiResult.ok {
                count = apiResult.data.count
            }
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "platformViewCell")
        
        if let platforms = viewModel?.apiResult?.data.result {
            cell.textLabel?.text = platforms[indexPath.row].name
        }
        
        return cell
    }
}
