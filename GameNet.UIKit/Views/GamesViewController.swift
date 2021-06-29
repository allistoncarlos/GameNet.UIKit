//
//  GamesViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import UIKit

class GamesViewController: UIViewController {
    // MARK: - Properties
    var presenter: GamePresenterProtocol?
    var games: [GameViewModel] = []
    
    // MARK: - Outlets
    @IBOutlet weak var gamesCollectionView: UICollectionView?
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.gamesViewTitle
        self.gamesCollectionView?.dataSource = self
        self.gamesCollectionView?.delegate = self
        
        presenter = GamePresenter(service: GameService(apiResource: Constants.gameResource), delegate: self)
        presenter?.load()
    }
}

extension GamesViewController: GamePresenterDelegate {
    func render(games: [GameViewModel]) {
        self.games = games
        
        
        gamesCollectionView?.reloadData()
        
        print(games)
    }
}

enum ImageError: Error {
    case couldNotLoadImage
}

extension GamesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameViewCell", for: indexPath) as! GameViewCell
        let actualGame = self.games[indexPath.row]
        
        loadGameCover(url: actualGame.cover, imageView: cell.gameImage!)
        
        return cell
    }
    
    // MARK: - FlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let iPhoneSize = 130
        let iPadSize = 325
        
        let resultSize = UIDevice.current.userInterfaceIdiom == .phone ? iPhoneSize : iPadSize
        
        return CGSize(width: resultSize, height: resultSize)
    }
    
    // MARK: - Private Funcs
    func loadGameCover(url: String, imageView: UIImageView) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageUrl = URL(string: url) else { return }
            
            do {
                let imageData: NSData = try NSData(contentsOf: imageUrl)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    imageView.image = image
                }
            }
            catch {
                // TODO: colocar imagem de placeholder
                print(error.localizedDescription)
            }
        }
    }
}
