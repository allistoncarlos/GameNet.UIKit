//
//  DashboardViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import GameNet_Network
import KeychainAccess
import UIKit

class GameDetailTapGestureRecognizer: UITapGestureRecognizer {
    var playingGame: PlayingGame?
}

class ListDetailTapGestureRecognizer: UITapGestureRecognizer {
    var listType: ListType = .custom
    var id: String = ""
}

class DashboardViewController: BaseViewController, StoryboardCoordinated {
    // MARK: - Properties

    var viewModel: DashboardViewModelProtocol?
    var coordinator: DashboardCoordinator?

    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var playingGamesView: UIStackView!
    @IBOutlet weak var physicalDigitalGamesView: UIStackView!
    @IBOutlet weak var finishedByYearView: UIStackView!
    @IBOutlet weak var boughtByYearView: UIStackView!
    @IBOutlet weak var gameByPlatformView: UIStackView!

    @IBOutlet weak var totalGamesLabel: UILabel!

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        let cornerRadius: CGFloat = 10

        super.viewDidLoad()

        self.navigationItem.title = Constants.dashboardViewTitle
        playingGamesView.layer.cornerRadius = cornerRadius
        physicalDigitalGamesView.layer.cornerRadius = cornerRadius
        finishedByYearView.layer.cornerRadius = cornerRadius
        boughtByYearView.layer.cornerRadius = cornerRadius
        gameByPlatformView.layer.cornerRadius = cornerRadius

        playingGamesView.translatesAutoresizingMaskIntoConstraints = false
        physicalDigitalGamesView.translatesAutoresizingMaskIntoConstraints = false
        finishedByYearView.translatesAutoresizingMaskIntoConstraints = false
        boughtByYearView.translatesAutoresizingMaskIntoConstraints = false
        gameByPlatformView.translatesAutoresizingMaskIntoConstraints = false

        viewModel?.renderData = renderDashboard()

        Task {
            await viewModel?.fetchData()
        }
    }

    override func viewWillLayoutSubviews() {
        self.setupStatusBar()
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DashboardViewController {
    private func renderUnfinishedGameplaySession(playingGames: [PlayingGame]) {
        let hasUnfinishedGameplaySession = !playingGames.filter { $0.latestGameplaySession?.finish == nil }.isEmpty

        if hasUnfinishedGameplaySession,
           let unfinishedGame = playingGames.filter({ $0.latestGameplaySession?.finish == nil }).first {
            let dialogMessage = UIAlertController(
                title: "Gameplay não finalizado",
                message: "\(unfinishedGame.name) tem um gameplay não finalizado",
                preferredStyle: .alert)

            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            dialogMessage.addAction(ok)

            self.present(dialogMessage, animated: true, completion: nil)
        }
    }

    fileprivate func renderDashboard() -> () -> Void {
        return { [weak self] in
            DispatchQueue.main.async {
                guard let playingGames = self?.viewModel?.result?.playingGames,
                      let totalGames = self?.viewModel?.result?.totalGames,
                      let totalPrice = self?.viewModel?.result?.totalPrice,
                      let physicalDigital = self?.viewModel?.result?.physicalDigital,
                      let finishedGamesByYear = self?.viewModel?.result?.finishedByYear,
                      let boughtGamesByYear = self?.viewModel?.result?.boughtByYear,
                      let gamesByPlatform = self?.viewModel?.result?.gamesByPlatform?.platforms
                else { return }

                self?.renderUnfinishedGameplaySession(playingGames: playingGames)

                // Playing Games
                for playingGame in playingGames {
                    if let titleSubtitleStackView = self?.renderTitleSubtitle(
                        title: playingGame.name,
                        subtitle: playingGame.latestGameplaySession?.start.toFormattedString() ?? "") {
                        let gesture = GameDetailTapGestureRecognizer(
                            target: self,
                            action: #selector(self?.showGameDetail))
                        gesture.playingGame = playingGame
                        titleSubtitleStackView.addGestureRecognizer(gesture)

                        self?.playingGamesView.addArrangedSubview(titleSubtitleStackView)
                    }
                }

                // Physical Digital Games
                self?.totalGamesLabel.text = "\(totalGames) jogos"

                // TotalPrice
                let totalPriceLabel = UILabel()
                totalPriceLabel.font = UIFont.dashboardPlayingGameSubtitle

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .currency
                if let formattedTotalPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) {
                    totalPriceLabel.text = formattedTotalPrice
                }

                self?.physicalDigitalGamesView?.addArrangedSubview(totalPriceLabel)

                // Digital
                if let digitalStackView = self?.renderBadgeText(badge: physicalDigital.digital, text: "Digitais") {
                    self?.physicalDigitalGamesView?.addArrangedSubview(digitalStackView)
                }

                // Physical
                if let physicalStackView = self?.renderBadgeText(badge: physicalDigital.physical, text: "Físicos") {
                    self?.physicalDigitalGamesView?.addArrangedSubview(physicalStackView)
                }

                // Finished By Year
                for finishedGameByYear in finishedGamesByYear {
                    if let finishedByYearStackView =
                        self?.renderBadgeText(badge: finishedGameByYear.total, text: "\(finishedGameByYear.year)") {
                        let gesture = ListDetailTapGestureRecognizer(
                            target: self,
                            action: #selector(self?.showListDetail))
                        gesture.id = String(finishedGameByYear.year)
                        gesture.listType = .finishedByYear
                        finishedByYearStackView.addGestureRecognizer(gesture)

                        self?.finishedByYearView?.addArrangedSubview(finishedByYearStackView)
                    }
                }

                // Bought By Year
                for boughtGameByYear in boughtGamesByYear {
                    if let boughtByYearStackView = self?.renderBadgeText(badge: boughtGameByYear.quantity,
                                                                         text: "\(boughtGameByYear.year)",
                                                                         subtitle: "\(boughtGameByYear.total)") {
                        let gesture = ListDetailTapGestureRecognizer(
                            target: self,
                            action: #selector(self?.showListDetail))
                        gesture.id = String(boughtGameByYear.year)
                        gesture.listType = .boughtByYear
                        boughtByYearStackView.addGestureRecognizer(gesture)

                        self?.boughtByYearView?.addArrangedSubview(boughtByYearStackView)
                    }
                }

                // Games By Platform
                for platform in gamesByPlatform {
                    if let platformStackView = self?.renderBadgeText(badge: platform.platformGamesTotal,
                                                                     text: "\(platform.name)") {
                        self?.gameByPlatformView?.addArrangedSubview(platformStackView)
                    }
                }
            }
        }
    }

    // MARK: - Private Functions

    private func renderTitleSubtitle(title: String, subtitle: String) -> UIStackView {
        let titleSubtitleStackView = UIStackView()
        titleSubtitleStackView.axis = .vertical
        titleSubtitleStackView.alignment = .leading
        titleSubtitleStackView.distribution = .equalSpacing

        let titleLabel = UILabel()
        titleLabel.font = UIFont.dashboardPlayingGameTitle
        titleLabel.text = title
        titleSubtitleStackView.addArrangedSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.dashboardPlayingGameSubtitle
        subtitleLabel.text = subtitle
        titleSubtitleStackView.addArrangedSubview(subtitleLabel)

        return titleSubtitleStackView
    }

    private func renderBadgeText(badge: Int, text: String, subtitle: String = "") -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        let badgeLabel = UILabel()
        badgeLabel.text = "\(badge)"
        badgeLabel.font = UIFont.dashboardPlayingGameTitle
        badgeLabel.textAlignment = .center

        let numberConstraints = [
            badgeLabel.widthAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(numberConstraints)

        stackView.addArrangedSubview(badgeLabel)

        let title = UILabel()
        title.text = text
        title.font = UIFont.dashboardPlayingGameTitle
        stackView.addArrangedSubview(title)

        return stackView
    }

    // MARK: - Actions

    @objc func showGameDetail(sender: GameDetailTapGestureRecognizer) {
        if let id = sender.playingGame?.id, let name = sender.playingGame?.name {
            coordinator?.showGameDetail(id: id, name: name)
        }
    }

    @objc func showListDetail(sender: ListDetailTapGestureRecognizer) {
        coordinator?.showListDetail(id: sender.id, listType: sender.listType)
    }
}
