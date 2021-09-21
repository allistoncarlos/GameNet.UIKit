//
//  TesteViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 20/09/21.
//

import UIKit
import SDWebImage

class TesteViewController: UIViewController, UIScrollViewDelegate {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
        self.scrollView.delegate = self
        self.stackView.distribution = .equalSpacing
        
        
        
        
        
        
        let cover = "http://allistoncarlos.blob.core.windows.net/gamenet/playstation-4/persona-5.jpg"
        
        // ImageView
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: cover))
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 15),
            imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 315),
//            imageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        // Title
        let title = UILabel()
        title.text = "Persona 5"
        title.backgroundColor = .blue
        stackView.addArrangedSubview(title)
        
        let titleConstraints = [
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(titleConstraints)
        
        // Platform
        let platform = UILabel()
        platform.text = "Playstation 4"
        platform.backgroundColor = .red
        stackView.addArrangedSubview(platform)
        
        let platformConstraints = [
            platform.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            platform.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(platformConstraints)
        
        // Price
        let value = UILabel()
        value.text = "Preço: R$ 150,00"
        value.backgroundColor = .green
        stackView.addArrangedSubview(value)
        
        let valueConstraints = [
            value.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
            value.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(valueConstraints)
        
        // Bought Date
        let boughtDate = UILabel()
        boughtDate.text = "Data de Compra: 01/01/2019"
        boughtDate.backgroundColor = .red
        stackView.addArrangedSubview(boughtDate)
        
        let boughtDateConstraints = [
            boughtDate.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
            boughtDate.heightAnchor.constraint(equalToConstant: 20),
        ]
        NSLayoutConstraint.activate(boughtDateConstraints)
        
        // Teste
        let teste = UILabel()
        
        teste.backgroundColor = .red
        stackView.addArrangedSubview(teste)
        
        let testeConstraints = [
            teste.topAnchor.constraint(equalTo: boughtDate.bottomAnchor, constant: 10),
            teste.heightAnchor.constraint(equalToConstant: 20),
        ]
        NSLayoutConstraint.activate(testeConstraints)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}


class Teste2ViewController: UIViewController, UIScrollViewDelegate {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
        self.scrollView.delegate = self
        self.stackView.distribution = .equalSpacing

        
//        let cover = "http://allistoncarlos.blob.core.windows.net/gamenet/playstation-4/persona-5.jpg"
//
//        // ImageView
//        let imageView = UIImageView()
//        imageView.sd_setImage(with: URL(string: cover))
//
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.addArrangedSubview(imageView)
//
//        let imageViewConstraints = [
//            imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 15),
//            imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 315),
////            imageView.heightAnchor.constraint(equalToConstant: 300)
//        ]
//        NSLayoutConstraint.activate(imageViewConstraints)
//
//        // Title
//        let title = UILabel()
//        title.text = "Persona 5"
//        title.backgroundColor = .blue
//        stackView.addArrangedSubview(title)
//
//        let titleConstraints = [
//            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
//            title.heightAnchor.constraint(equalToConstant: 20)
//        ]
//        NSLayoutConstraint.activate(titleConstraints)
//
//        // Platform
//        let platform = UILabel()
//        platform.text = "Playstation 4"
//        platform.backgroundColor = .red
//        stackView.addArrangedSubview(platform)
//
//        let platformConstraints = [
//            platform.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
//            platform.heightAnchor.constraint(equalToConstant: 20)
//        ]
//        NSLayoutConstraint.activate(platformConstraints)
//
//        // Price
//        let value = UILabel()
//        value.text = "Preço: R$ 150,00"
//        value.backgroundColor = .green
//        stackView.addArrangedSubview(value)
//
//        let valueConstraints = [
//            value.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
//            value.heightAnchor.constraint(equalToConstant: 20)
//        ]
//        NSLayoutConstraint.activate(valueConstraints)
//
//        // Bought Date
//        let boughtDate = UILabel()
//        boughtDate.text = "Data de Compra: 01/01/2019"
//        boughtDate.backgroundColor = .red
//        stackView.addArrangedSubview(boughtDate)
//
//        let boughtDateConstraints = [
//            boughtDate.topAnchor.constraint(equalTo: platform.bottomAnchor, constant: 10),
//            boughtDate.heightAnchor.constraint(equalToConstant: 20),
//        ]
//        NSLayoutConstraint.activate(boughtDateConstraints)
//
//        // Teste
//        let teste = UILabel()
//
//        teste.backgroundColor = .red
//        stackView.addArrangedSubview(teste)
//
//        let testeConstraints = [
//            teste.topAnchor.constraint(equalTo: boughtDate.bottomAnchor, constant: 10),
//            teste.heightAnchor.constraint(equalToConstant: 20),
//        ]
//        NSLayoutConstraint.activate(testeConstraints)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class Teste3ViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        self.imageView.load(url: URL(string: "http://allistoncarlos.blob.core.windows.net/gamenet/playstation-4/persona-5.jpg")!)
    }
}
