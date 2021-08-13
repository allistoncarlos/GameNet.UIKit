//
//  GamesViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/06/21.
//

import UIKit

enum ImageError: Error {
    case couldNotLoadImage
}

class GamesViewController: UIViewController {
    // MARK: - Properties
    var presenter: GamePresenterProtocol?
    var games: [GameViewModel] = []
    var pagedResultViewModel: PagedResultViewModel<GameViewModel>?
    var isLoading: Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var gamesCollectionView: UICollectionView?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Constants.gamesViewTitle
        self.gamesCollectionView?.dataSource = self
        self.gamesCollectionView?.delegate = self
        
        self.isLoading = true
        presenter?.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let statusBarFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = Constants.primaryColor
        view.addSubview(statusBarView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let gamesCollectionView = self.gamesCollectionView else { return }
        
        if gamesCollectionView.contentOffset.y >= (gamesCollectionView.contentSize.height - gamesCollectionView.bounds.size.height) {
            
            if !isLoading {
                self.isLoading = true
                
                guard let page = pagedResultViewModel?.page else { return }
                presenter?.load(page: page + 1)
            }
        }
    }
}

extension GamesViewController: GamePresenterDelegate {
    func render(pagedResult: PagedResultViewModel<GameViewModel>?) {
        if let pagedResult = pagedResult {
            self.pagedResultViewModel = pagedResult
            self.games += pagedResult.result
            
            print(pagedResult.result)
        }
        
        self.isLoading = false
        gamesCollectionView?.reloadData()
    }
}

extension GamesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameViewCell", for: indexPath) as! GameViewCell
        
        let actualGame = self.games[indexPath.row]
        
        cell.gameImage.load(url: actualGame.cover)
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1)
        
        return cell
    }
    
    // MARK: - FlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5
        let resultSize = (collectionView.bounds.width / columns) - 15

        return CGSize(width: resultSize, height: resultSize)
    }
}
