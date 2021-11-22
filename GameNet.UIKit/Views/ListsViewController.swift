//
//  ListsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation
import UIKit

class ListsViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: ListsViewModelProtocol?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.listsViewTitle
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
    
    override func viewWillLayoutSubviews() {
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listViewCell")
        
        if let platforms = viewModel?.apiResult?.data.result {
            cell.textLabel?.text = platforms[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPlatform = viewModel?.apiResult?.data.result[indexPath.row]
        
        showEditView(id: currentPlatform?.id)
    }
    
    // MARK: - Navigation Selectors
    @objc func addTapped(_ sender: UIButton?) {
        showEditView()
    }
    
    // MARK: - Private Funcs
    private func showEditView(id: String? = nil) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: EditPlatformViewController.self)

        let editPlatformViewController =
            storyboard.instantiateViewController(identifier: identifier) as EditPlatformViewController
        editPlatformViewController.delegate = self
        editPlatformViewController.platformId = id
        
        editPlatformViewController.modalPresentationStyle = .automatic
        editPlatformViewController.modalTransitionStyle = .crossDissolve
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [editPlatformViewController]
        
        present(navigationController, animated: true, completion: nil)*/
    }
}

//extension PlatformsViewController: EditListViewControllerDelegate {
//    func savedData() {
//        dismiss(animated: true, completion: nil)
//        self.viewModel?.fetchData()
//    }
//}
