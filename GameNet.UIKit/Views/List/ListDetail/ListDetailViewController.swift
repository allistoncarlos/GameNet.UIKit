//
//  ListDetailViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/03/22.
//

import Foundation
import UIKit

enum ListType {
    case finishedByYear
    case boughtByYear
    case custom
}

final class ListDetailViewController: BaseViewController {
    // MARK: - MainView
    let mainView = View()

    // MARK: - Properties
    var listId: String?
    var listName: String?
    var listType: ListType = .custom
    var viewModel: ListDetailViewModelProtocol?
    var coordinator: ListCoordinator?

    // MARK: - Override funcs
    override func loadView() {
        mainView.tableViewDelegate = self
        mainView.tableViewDataSource = self
        view = mainView
    }

    override func viewWillLayoutSubviews() {
        self.setupStatusBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let listId = listId {
            setTitle(listId: listId, listName: listName)

            viewModel?.renderData = renderData()

            viewModel?.listType = listType
            Task {
                await viewModel?.fetchData(id: listId)
            }
        } else {
            self.setupModalNavigationBar(title: Constants.editListViewTitle)
        }
    }

    // MARK: - Private funcs
    private func setTitle(listId: String, listName: String?) {
        switch self.listType {
        case .finishedByYear:
            self.title = "Finalizados em \(listId)"
        case .boughtByYear:
            self.title = "Comprados em \(listId)"
        case .custom:
            self.title = listName
        }
    }

    private func renderData() -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.mainView.reloadData()
            }
        }
    }
}

extension ListDetailViewController: UITableViewDelegate,
                                    UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0

        if let result = viewModel?.result {
            count = result.count
        }

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListItemCell(style: .default, reuseIdentifier: "listItemViewCell")

        if let listItems = viewModel?.result {
            let listItem = listItems[indexPath.row]

            if let platform = listItem.platform,
               let cover = listItem.cover {
                cell.name = listItem.name
                cell.platform = platform
                cell.loadCover(url: cover)
            }

            var detail = ""

            switch listType {
            case .finishedByYear:
                detail = listItem.finish?.toFormattedString() ?? ""
            case .boughtByYear:
                detail = "R$ \(listItem.value ?? 0)"
            case .custom:
                break
            }

            cell.detail = detail
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let listItem = viewModel?.result?[indexPath.row],
           let userGameId = listItem.userGameId {
            coordinator?.showGameDetail(id: userGameId, name: listItem.name)
        }
    }
}
