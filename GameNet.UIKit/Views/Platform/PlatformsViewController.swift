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
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        viewModel?.renderData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupStatusBar()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.setupStatusBar()
    }
    
    // MARK: - UITableViewDelegate
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
    
    // MARK: - Navigation Selectors
    @objc func addTapped(_ sender: UIButton?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: EditPlatformViewController.self)

        let editPlatformViewController =
            storyboard.instantiateViewController(identifier: identifier) as EditPlatformViewController
        editPlatformViewController.delegate = self
        
        editPlatformViewController.modalPresentationStyle = .automatic
        editPlatformViewController.modalTransitionStyle = .crossDissolve
        
        present(editPlatformViewController, animated: true, completion: nil)
        
    }
}

extension PlatformsViewController: EditPlatformViewControllerDelegate {
    func savedData() {
        dismiss(animated: true, completion: nil)
        self.viewModel?.fetchData()
    }
}
