//
//  ListsViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation
import UIKit

class ListsViewController: BaseViewController,
                            UITableViewDelegate,
                            UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: ListsViewModelProtocol?
    var coordinator: ListCoordinator?

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.navigationItem.title = Constants.listsViewTitle
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        barButtonItem.tintColor = UIColor.white

        self.navigationItem.rightBarButtonItem = barButtonItem

        viewModel?.renderData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        Task {
            await viewModel?.fetchData()
        }
    }

    override func viewWillLayoutSubviews() {
        self.setupStatusBar()
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0

        if let result = viewModel?.result {
            count = result.count
        }

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listViewCell")

        if let lists = viewModel?.result {
            cell.textLabel?.text = lists[indexPath.row].name
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentList = viewModel?.result?[indexPath.row],
           let id = currentList.id,
           let name = currentList.name {
            coordinator?.showListDetail(id: id, name: name, listType: .custom)
        }
    }

    // MARK: - Navigation Selectors
    @objc func addTapped(_ sender: UIButton?) {
        coordinator?.showList()
    }
}

extension ListsViewController: EditListViewControllerDelegate {
    func savedData() {
        dismiss(animated: true, completion: nil)

        Task {
            await self.viewModel?.fetchData()
        }
    }
}
