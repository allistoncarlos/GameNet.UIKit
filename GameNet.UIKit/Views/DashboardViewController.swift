//
//  DashboardViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import KeychainAccess

class GameDetailTapGestureRecognizer: UITapGestureRecognizer {
    var playingGame: PlayingGameModel?
}

class DashboardViewController: UIViewController {
    // MARK: - Properties
    var viewModel: DashboardViewModelProtocol?
    
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
        
        viewModel?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupStatusBar()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameDetailViewController = segue.destination as? GameDetailViewController else { return }
        
        let playingGame = sender as? PlayingGameModel
        gameDetailViewController.title = playingGame?.name
        gameDetailViewController.gameId = playingGame?.id
    }
}

extension DashboardViewController {
    fileprivate func renderDashboard() -> () -> () {
        return { [weak self] in
            DispatchQueue.main.async {
                guard let playingGames = self?.viewModel?.apiResult?.data.playingGames,
                      let totalGames = self?.viewModel?.apiResult?.data.totalGames,
                      let totalPrice = self?.viewModel?.apiResult?.data.totalPrice,
                      let physicalDigital = self?.viewModel?.apiResult?.data.physicalDigital,
                      let finishedGamesByYear = self?.viewModel?.apiResult?.data.finishedByYear,
                      let boughtGamesByYear = self?.viewModel?.apiResult?.data.boughtByYear,
                      let gamesByPlatform = self?.viewModel?.apiResult?.data.gamesByPlatform?.platforms
                else { return }
                
                // Playing Games
                for playingGame in playingGames {
                    if let titleSubtitleStackView = self?.renderTitleSubtitle(title: playingGame.name, subtitle: playingGame.latestGameplaySession.start.toFormattedString()) {
                    
                        let gesture = GameDetailTapGestureRecognizer(target: self, action: #selector(self?.showGameDetail))
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
                totalPriceLabel.text = "R$ \(totalPrice),00"
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
                    if let finishedByYearStackView = self?.renderBadgeText(badge: finishedGameByYear.total, text: "\(finishedGameByYear.year)") {
                        self?.finishedByYearView?.addArrangedSubview(finishedByYearStackView)
                    }
                }
                
                // Bought By Year
                for boughtGameByYear in boughtGamesByYear {
                    if let boughtByYearStackView = self?.renderBadgeText(badge: boughtGameByYear.quantity,
                                                                         text: "\(boughtGameByYear.year)",
                                                                         subtitle: "\(boughtGameByYear.total)") {
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
            badgeLabel.widthAnchor.constraint(equalToConstant: 50)
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
    @objc func showGameDetail(sender : GameDetailTapGestureRecognizer) {
        performSegue(withIdentifier: "ShowGameDetailSegue", sender: sender.playingGame)
    }
}
