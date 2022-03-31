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
                detailLabel.sizeToFit()
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
        nameLabel.numberOfLines = 2
        nameLabel.setContentHuggingPriority(.required, for: .vertical)
        nameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        nameLabel.font = UIFont.listItemCellGameName
        nameLabel.translatesAutoresizingMaskIntoConstraints = true
        return nameLabel
    }()

    private var platformLabel: UILabel = {
        let platformLabel = UILabel()
        platformLabel.font = UIFont.listItemCellPlatform
        platformLabel.translatesAutoresizingMaskIntoConstraints = true
        platformLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        platformLabel.setContentHuggingPriority(.required, for: .vertical)
        return platformLabel
    }()

    private var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.listItemCellDetail
        detailLabel.translatesAutoresizingMaskIntoConstraints = true
        return detailLabel
    }()

    private var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
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
            coverImage.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.25),
            coverImage.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, constant: -20)
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ListItemCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = ListItemCell(style: .default, reuseIdentifier: "listItemCell")
        cell.name = "The Legend of Zelda: Breath of the Wild"
        cell.platform = "Nintendo Switch"
        cell.detail = "R$ 180,00"
        cell.loadCover(url:
                        "http://allistoncarlos.blob.core.windows.net/gamenet/nintendo-switch/the-legend-of-zelda-breath-of-the-wild.jpg")

        return cell
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

struct ListItemCell_Preview: PreviewProvider {
    static var previews: some View {
        ListItemCellRepresentable()
            .preferredColorScheme(.dark)
            .frame(width: UIScreen.main.bounds.width, height: 140, alignment: .center)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))

        ListItemCellRepresentable()
            .preferredColorScheme(.dark)
            .frame(width: UIScreen.main.bounds.width, height: 240, alignment: .center)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (129-inch) (5th generation)"))
    }
}
#endif
