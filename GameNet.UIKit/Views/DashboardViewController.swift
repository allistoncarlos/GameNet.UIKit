//
//  DashboardViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 27/06/21.
//

import UIKit
import KeychainAccess

class DashboardViewController: UIViewController {
    // MARK: - Properties
    var presenter: DashboardPresenterProtocol?
    
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
        
        presenter?.fetchData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DashboardViewController: DashboardPresenterDelegate {
    func renderLoading() {
        
    }
    
    func render(data: DashboardModel) {
        guard let playingGames = data.playingGames,
              let totalGames = data.totalGames,
              let totalPrice = data.totalPrice,
              let physicalDigital = data.physicalDigital,
              let finishedGamesByYear = data.finishedByYear,
              let boughtGamesByYear = data.boughtByYear,
              let gamesByPlatform = data.gamesByPlatform?.platforms
        else { return }
        
        // Playing Games
        for playingGame in playingGames {
            let titleSubtitleStackView = renderTitleSubtitle(title: playingGame.name, subtitle: playingGame.latestGameplaySession.start.toFormattedString())
            playingGamesView.addArrangedSubview(titleSubtitleStackView)
        }
        
        // Physical Digital Games
        totalGamesLabel.text = "\(totalGames) jogos"
        
        // TotalPrice
        let totalPriceLabel = UILabel()
        totalPriceLabel.font = UIFont.dashboardPlayingGameSubtitle
        totalPriceLabel.text = "R$ \(totalPrice),00"
        physicalDigitalGamesView?.addArrangedSubview(totalPriceLabel)

        // Digital
        let digitalStackView = renderBadgeText(badge: physicalDigital.digital, text: "Digitais")
        physicalDigitalGamesView?.addArrangedSubview(digitalStackView)
        
        // Physical
        let physicalStackView = renderBadgeText(badge: physicalDigital.physical, text: "Físicos")
        physicalDigitalGamesView?.addArrangedSubview(physicalStackView)
        
        // Finished By Year
        for finishedGameByYear in finishedGamesByYear {
            let finishedByYearStackView = renderBadgeText(badge: finishedGameByYear.total, text: "\(finishedGameByYear.year)")
            finishedByYearView?.addArrangedSubview(finishedByYearStackView)
        }
        
        // Bought By Year
        for boughtGameByYear in boughtGamesByYear {
            let boughtByYearStackView = renderBadgeText(badge: boughtGameByYear.quantity,
                                                        text: "\(boughtGameByYear.year)",
                                                        subtitle: "\(boughtGameByYear.total)")
            boughtByYearView?.addArrangedSubview(boughtByYearStackView)
        }
        
        // Games By Platform
        for platform in gamesByPlatform {
            let platformStackView = renderBadgeText(badge: platform.platformGamesTotal,
                                                        text: "\(platform.name)")
            gameByPlatformView?.addArrangedSubview(platformStackView)
        }
    }
    
    func render(error: Error) {
        
    }
    
    func render(errors: [String]) {
        
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
}
