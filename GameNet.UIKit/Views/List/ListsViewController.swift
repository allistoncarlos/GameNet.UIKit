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
        
        if let lists = viewModel?.apiResult?.data.result {
            cell.textLabel?.text = lists[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentList = viewModel?.apiResult?.data.result[indexPath.row]
        
        showEditView(id: currentList?.id)
    }
    
    // MARK: - Navigation Selectors
    @objc func addTapped(_ sender: UIButton?) {
        showEditView()
    }
    
    // MARK: - Private Funcs
    private func showEditView(id: String? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: EditListViewController.self)

        let editListViewController =
            storyboard.instantiateViewController(identifier: identifier) as EditListViewController
        editListViewController.delegate = self
        editListViewController.listId = id
        
        editListViewController.modalPresentationStyle = .automatic
        editListViewController.modalTransitionStyle = .crossDissolve
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [editListViewController]
        
        present(navigationController, animated: true, completion: nil)
    }
}

extension ListsViewController: EditListViewControllerDelegate {
    func savedData() {
        dismiss(animated: true, completion: nil)
        self.viewModel?.fetchData()
    }
}
