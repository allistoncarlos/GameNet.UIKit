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
    @IBOutlet weak var playingGamesView: UIStackView!
    @IBOutlet weak var physicalDigitalGamesView: UIStackView!
    
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
              let physicalDigital = data.physicalDigital
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

        let digitalStackView = renderBadgeText(badge: physicalDigital.digital, text: "Digitais")
        physicalDigitalGamesView?.addArrangedSubview(digitalStackView)
        
        let physicalStackView = renderBadgeText(badge: physicalDigital.physical, text: "Físicos")
        physicalDigitalGamesView?.addArrangedSubview(physicalStackView)
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
        
        let playingGameTitleLabel = UILabel()
        playingGameTitleLabel.font = UIFont.dashboardPlayingGameTitle
        playingGameTitleLabel.text = title
        titleSubtitleStackView.addArrangedSubview(playingGameTitleLabel)

        let playingGameSubtitleLabel = UILabel()
        playingGameSubtitleLabel.font = UIFont.dashboardPlayingGameSubtitle
        playingGameSubtitleLabel.text = subtitle
        titleSubtitleStackView.addArrangedSubview(playingGameSubtitleLabel)
        
        return titleSubtitleStackView
    }
    
    private func renderBadgeText(badge: Int, text: String, hasSubtitle: Bool = false) -> UIStackView {
        let physicalStackView = UIStackView()
        physicalStackView.axis = .horizontal
        physicalStackView.alignment = .center
        physicalStackView.distribution = .fillProportionally

        let physicalNumberLabel = UILabel()
        physicalNumberLabel.text = "\(badge)"
        physicalNumberLabel.font = UIFont.dashboardPlayingGameTitle
        
        let physicalNumberConstraints = [
            physicalNumberLabel.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(physicalNumberConstraints)
        
        physicalStackView.addArrangedSubview(physicalNumberLabel)
        
        let physicalLabel = UILabel()
        physicalLabel.text = text
        physicalLabel.font = UIFont.dashboardPlayingGameTitle
        physicalStackView.addArrangedSubview(physicalLabel)
        
        return physicalStackView
    }
}
