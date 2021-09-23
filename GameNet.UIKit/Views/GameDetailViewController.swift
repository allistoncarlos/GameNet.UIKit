//
//  GameDetailViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 15/08/21.
//

import UIKit
import SDWebImage

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    var presenter: GameDetailPresenterProtocol?
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
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let gameId = gameId {
            presenter?.get(id: gameId)
            presenter?.getGameplaySessions(id: gameId)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let statusBarFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = Constants.primaryColor
        view.addSubview(statusBarView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
        if UIDevice.current.userInterfaceIdiom != .phone {
            imageHeightConstraint.constant = 450
            
            if UIDevice.current.orientation.isPortrait {
                imageHeightConstraint.constant = 600
            }
        }
    }
}

extension GameDetailViewController: GameDetailPresenterDelegate {
    func render(result: GameDetailViewModel?) {
        guard let cover = result?.cover else { return }
        
        // ImageView
        self.imageView.sd_setImage(with: URL(string: cover))
        
        self.gameTitle.text = result?.name
        self.platform.text = result?.platform
        
        if let valueDecimal = result?.value {
            self.price.text = "Preço: R$ \(valueDecimal)"
        }
        
        if let boughtDateValue = result?.boughtDate {
            self.boughtDate.text = "Data de Compra: \(boughtDateValue.toFormattedString())"
        }
        
        if let latestGameplays = result?.gameplays {
            
            if let latestGameplay = latestGameplays.last {
                self.playingSince.text = "Jogando desde: \(latestGameplay.start.toFormattedString())"
            }
        }
    }
    
    func renderGameplays(result: GameplaySessionsViewModel?) {
        if let result = result {
            gameplays.isHidden = false
            
            renderGameplayLabel(text: "Total de \(result.totalGameplayTime)")
            renderGameplayLabel(text: "Média de \(result.averageGameplayTime) por sessão")
            
            for gameplaySession in result.sessions {
                renderGameplayLabel(
                    text: "\(gameplaySession.start.toFormattedString()) até \(gameplaySession.finish.toFormattedString())\nTotal de \(gameplaySession.totalGameplayTime)",
                    numberOfLines: 2)
            }
        }
    }
    
    // MARK: - Private Funcs
    private func renderGameplayLabel(text: String, numberOfLines: Int = 1) {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.text = text
        
//            let totalGameplayTimeConstraints = [
//                totalGameplayTime.topAnchor.constraint(equalTo: gameplaysTitle.bottomAnchor, constant: 5),
//                totalGameplayTime.heightAnchor.constraint(equalToConstant: 20)
//            ]
//            NSLayoutConstraint.activate(totalGameplayTimeConstraints)
            
        gameplays.addArrangedSubview(label)
    }
}
