//
//  GameDetailViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 15/08/21.
//

import UIKit
import SDWebImage

class GameDetailViewController: BaseViewController, UIScrollViewDelegate, StoryboardCoordinated {
    // MARK: - Properties
    var viewModel: GameDetailViewModelProtocol?
    var gameId: String?

    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var boughtDate: UILabel!
    @IBOutlet weak var playingSince: UILabel!
    @IBOutlet weak var gameplays: UIStackView!

    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    // MARK: - Override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let gameId = gameId {
            viewModel?.renderData = renderData()
            viewModel?.renderGameplayData = renderGameplayData()

            viewModel?.get(id: gameId)
            viewModel?.getGameplaySessions(id: gameId)
        }
    }

    override func viewWillLayoutSubviews() {
        self.setupStatusBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.gameTitle.numberOfLines = 0

        if UIDevice.current.userInterfaceIdiom != .phone {
            imageHeightConstraint.constant = 450

            if UIDevice.current.orientation.isPortrait {
                imageHeightConstraint.constant = 600
            }
        }
    }
}

extension GameDetailViewController {
    fileprivate func renderData() -> () -> Void {
        return { [weak self] in
            DispatchQueue.main.async {
                if let result = self?.viewModel?.apiResult?.data {
                    // ImageView
                    self?.imageView.sd_setImage(with: URL(string: result.cover))

                    self?.gameTitle.text = result.name
                    self?.platform.text = result.platform

                    self?.price.text = "Pre??o: R$ \(result.value)"

                    self?.boughtDate.text = "Data de Compra: \(result.boughtDate.toFormattedString())"

                    if let latestGameplays = result.gameplays {

                        if let latestGameplay = latestGameplays.last {
                            self?.playingSince.text = "Jogando desde: \(latestGameplay.start.toFormattedString())"
                        }
                    }
                }
            }
        }
    }

    fileprivate func renderGameplayData() -> () -> Void {
        return { [weak self] in
            DispatchQueue.main.async {
                if let result = self?.viewModel?.apiGameplayResult?.data {
                    self?.gameplays.isHidden = false

                    self?.renderGameplayLabel(text: "Total de \(result.totalGameplayTime)" +
                                              "\nM??dia de \(result.averageGameplayTime)", numberOfLines: 2)

                    let sessions = result.sessions.sorted(by: { $0!.start >= $1!.start })

                    for gameplaySession in sessions {
                        if let gameplaySession = gameplaySession {
                            self?.renderGameplayLabel(
                                text: "\(gameplaySession.start.toFormattedString(dateFormat: Constants.dateFormat))"
                                    + " at?? " +
                                "\(gameplaySession.finish.toFormattedString(dateFormat: Constants.dateFormat))" +
                                "\nTotal de \(gameplaySession.totalGameplayTime)",
                                numberOfLines: 2)
                        }
                    }
                } else {
                    self?.gameplays.isHidden = true
                }
            }
        }
    }

    // MARK: - Private Funcs
    private func renderGameplayLabel(text: String, numberOfLines: Int = 1) {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.text = text
        label.font = UIFont(name: "Avenir Next", size: 16)

        gameplays.addArrangedSubview(label)
    }
}
