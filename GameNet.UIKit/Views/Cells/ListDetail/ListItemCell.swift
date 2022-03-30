//
//  ListItemCell.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 30/03/22.
//

import Foundation
import UIKit
import SDWebImage

final class ListItemCell: UITableViewCell, ViewCode {
    // MARK: - Properties
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }

    var platform: String = "" {
        didSet {
            platformLabel.text = platform
        }
    }

    var detail: String = "" {
        didSet {
            if !detail.isEmpty {
                detailLabel.text = detail
                verticalStackView.addArrangedSubview(detailLabel)
            }
        }
    }

    // MARK: - Controls
    private var coverImage: UIImageView = {
        let coverImage = UIImageView()
        coverImage.contentMode = .scaleAspectFill
        coverImage.clipsToBounds = true
        return coverImage
    }()

    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()

    private var platformLabel: UILabel = {
        let platformLabel = UILabel()
        return platformLabel
    }()

    private var detailLabel: UILabel = {
        let detailLabel = UILabel()
        return detailLabel
    }()

    private var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        return verticalStackView
    }()

    private var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        return horizontalStackView
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        applyViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewCode protocol
    func buildHierarchy() {
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(platformLabel)

        horizontalStackView.addArrangedSubview(coverImage)
        horizontalStackView.addArrangedSubview(verticalStackView)

        addSubview(horizontalStackView)
    }

    func setupConstraints() {
        let horizontalStackViewConstraints = [
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(horizontalStackViewConstraints)

        let coverImageConstraints = [
            coverImage.topAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: 10),
            coverImage.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor, constant: 10),
            coverImage.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.2),
            coverImage.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(coverImageConstraints)
    }

    func configureViews() {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    // MARK: - Public funcs
    func loadCover(url: String) {
        self.coverImage.sd_setImage(with: URL(string: url))
    }
}
