//
//  PlatformsViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 01/07/21.
//

import UIKit
import Swinject

class PlatformsViewController: BaseViewController,
                               StoryboardCoordinated,
                               UITableViewDelegate,
                               UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: PlatformsViewModelProtocol?
    var coordinator: PlatformCoordinator?

    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.navigationItem.title = Constants.platformsViewTitle
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "platformViewCell")

        if let platforms = viewModel?.result {
            cell.textLabel?.text = platforms[indexPath.row].name
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPlatform = viewModel?.result[indexPath.row]

        coordinator?.showPlatform(id: currentPlatform?.id)
    }

    // MARK: - Navigation Selectors
    @objc func addTapped(_ sender: UIButton?) {
        coordinator?.showPlatform()
    }
}

extension PlatformsViewController: EditPlatformViewControllerDelegate {
    func savedData() {
        dismiss(animated: true, completion: nil)

        Task {
            await self.viewModel?.fetchData()
        }
    }
}
