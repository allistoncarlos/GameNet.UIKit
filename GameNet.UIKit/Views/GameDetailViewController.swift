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
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        // Title
        let title = UILabel()
        title.backgroundColor = UIColor.blue
        title.text = result?.name
        stackView.addArrangedSubview(title)
        
        let titleConstraints = [
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(titleConstraints)
        
        // Platform
        let platform = UILabel()
        platform.backgroundColor = UIColor.blue
        platform.text = result?.platform
        stackView.addArrangedSubview(platform)
        
        let platformConstraints = [
            platform.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(platformConstraints)
        
        // Price
        let price = UILabel()
        price.backgroundColor = UIColor.blue
        price.text = "Preço: R$ \(result?.platform)"
        stackView.addArrangedSubview(price)
        
        let priceConstraints = [
            price.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(priceConstraints)
        
        // Deletar
        let price2 = UILabel()
        price2.backgroundColor = UIColor.blue
        price2.text = "Preço: R$ \(result?.platform)"
        price2.font = UIFont(name: "AvenirNext-DemiBold", size: 50)!
        stackView.addArrangedSubview(price2)
        
        let price2Constraints = [
            price2.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(price2Constraints)
        
        let price3 = UILabel()
        price3.backgroundColor = UIColor.blue
        price3.font = UIFont(name: "AvenirNext-DemiBold", size: 50)!
        price3.text = "Preço: R$ \(result?.platform)"
        stackView.addArrangedSubview(price3)
        
        let price3Constraints = [
            price3.topAnchor.constraint(equalTo: price2.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(price3Constraints)
        
        let price4 = UILabel()
        price4.backgroundColor = UIColor.blue
        price4.font = UIFont(name: "AvenirNext-DemiBold", size: 50)!
        price4.text = "Preço: R$ \(result?.platform)"
        stackView.addArrangedSubview(price4)
        
        let price4Constraints = [
            price4.topAnchor.constraint(equalTo: price3.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(price4Constraints)
        
        let price5 = UILabel()
        price5.backgroundColor = UIColor.blue
        price5.font = UIFont(name: "AvenirNext-DemiBold", size: 50)!
        price5.text = "Preço: R$ \(result?.platform)"
        stackView.addArrangedSubview(price5)
        
        let price5Constraints = [
            price5.topAnchor.constraint(equalTo: price4.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(price5Constraints)
        
        let price6 = UILabel()
        price6.backgroundColor = UIColor.blue
        price6.font = UIFont(name: "AvenirNext-DemiBold", size: 50)!
        price6.text = "Preço: R$ \(result?.platform)"
        stackView.addArrangedSubview(price6)
        
        let price6Constraints = [
            price6.topAnchor.constraint(equalTo: price5.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(price6Constraints)
        
        let price7 = UILabel()
        price7.backgroundColor = UIColor.blue
        price7.font = UIFont(name: "AvenirNext-DemiBold", size: 50)!
        price7.text = "Preço: R$ \(result?.platform)"
        stackView.addArrangedSubview(price7)
        
        let price7Constraints = [
            price7.topAnchor.constraint(equalTo: price6.bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(price7Constraints)
    }
}
