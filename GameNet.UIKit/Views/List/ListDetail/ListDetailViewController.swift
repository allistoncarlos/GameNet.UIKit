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
            setTitle(listId: listId)

            viewModel?.renderData = renderData()

            viewModel?.listType = listType
            viewModel?.fetchData(id: listId)
        } else {
            self.setupModalNavigationBar(title: Constants.editListViewTitle)
        }
    }

    // MARK: - Private funcs
    private func setTitle(listId: String) {
        switch self.listType {
        case .finishedByYear:
            self.title = "Finalizados em \(listId)"
        case .boughtByYear:
            self.title = "Comprados em \(listId)"
        case .custom:
            self.title = "CORRIGIR"
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

        if let apiResult = viewModel?.apiResult {
            if apiResult.ok {
                count = apiResult.data.count
            }
        }

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListItemCell(style: .default, reuseIdentifier: "listItemViewCell")

        if let listItems = viewModel?.apiResult?.data {
            let listItem = listItems[indexPath.row]

            if let name = listItem.name,
               let platform = listItem.platform
//               let cover = listItem.cover
            {
                cell.name = name
                cell.platform = platform
//                cell.loadCover(url: cover)
                cell.loadCover(url: "https://placehold.co/400x1900.jpg")
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
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let listItem = viewModel?.apiResult?.data[indexPath.row],
           let userGameId = listItem.userGameId,
           let name = listItem.name,
           let dashboardCoordinator = coordinator?.parentCoordinator as? DashboardCoordinator {
            dashboardCoordinator.showGameDetail(id: userGameId, name: name)
        }
    }
}
