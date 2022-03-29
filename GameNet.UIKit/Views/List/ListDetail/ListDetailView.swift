//
//  ListDetailView.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/03/22.
//

import Foundation
import UIKit

extension ListDetailViewController {
    final class View: UIView, ViewCode {
        // MARK: - Components
        private var tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()

        // MARK: - TableView properties
        var tableViewDelegate: UITableViewDelegate? {
            didSet {
                self.tableView.delegate = tableViewDelegate
            }
        }

        var tableViewDataSource: UITableViewDataSource? {
            didSet {
                self.tableView.dataSource = tableViewDataSource
            }
        }

        // MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)
            applyViewCode()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Public methods
        func reloadData() {
            self.tableView.reloadData()
        }

        // MARK: - ViewCode Protocol
        func buildHierarchy() {
            addSubview(tableView)
        }

        func setupConstraints() {
            let tableViewConstraints = [
                tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ]
            NSLayoutConstraint.activate(tableViewConstraints)
        }

        func configureViews() {
            backgroundColor = .systemBackground
        }
    }
}
