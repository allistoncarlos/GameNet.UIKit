//
//  GameDetailViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 15/08/21.
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    var presenter: GameDetailPresenterProtocol?
    var gameId: String?

    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let gameId = gameId {
            presenter?.get(id: gameId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
        self.scrollView.delegate = self
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let statusBarFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = Constants.primaryColor
        view.addSubview(statusBarView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

extension GameDetailViewController: GameDetailPresenterDelegate {
    func render(result: GameDetailViewModel?) {
        
        guard let cover = result?.cover else { return }
        
        // ImageView
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: cover))
        
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        // Title
        let title = UILabel()
        title.text = result?.name
        stackView.addArrangedSubview(title)
        
        let titleConstraints = [
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(titleConstraints)
        
        // Platform
        let platform = UILabel()
        platform.text = result?.platform
        stackView.addArrangedSubview(platform)
        
        let platformConstraints = [
            platform.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(platformConstraints)
        
        // Price
        if let valueDecimal = result?.value {
            let value = UILabel()
            value.text = "Preço: R$ \(valueDecimal)"
            stackView.addArrangedSubview(value)
            
            let valueConstraints = [
                value.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
            ]
            NSLayoutConstraint.activate(valueConstraints)
        }
        
        // Bought Date
        if let boughtDateValue = result?.boughtDate {
            let boughtDate = UILabel()
            boughtDate.text = "Data de Compra: \(boughtDateValue.toFormattedString())"
            stackView.addArrangedSubview(boughtDate)
            
            let boughtDateConstraints = [
                boughtDate.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
                boughtDate.bottomAnchor.constraint(equalTo: platform.bottomAnchor, constant: 100)
            ]
            NSLayoutConstraint.activate(boughtDateConstraints)
        }
    }
}
