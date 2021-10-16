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
    var viewModel: GamesViewModelProtocol?
    
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
        
        viewModel?.renderData = { [weak self] in
            DispatchQueue.main.async {
                self?.gamesCollectionView?.reloadData()
            }
        }
        
        viewModel?.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupStatusBar()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let gamesCollectionView = self.gamesCollectionView else { return }
        
        if gamesCollectionView.contentOffset.y >= (gamesCollectionView.contentSize.height - gamesCollectionView.bounds.size.height) {
            if let isLoading = viewModel?.isLoading {
                if !isLoading {
                    guard let page = viewModel?.apiResult?.data.page else { return }
                    viewModel?.fetchData(search: viewModel?.apiResult?.data.search, page: page + 1)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameDetailViewController = segue.destination as? GameDetailViewController else { return }
        
        let gameViewCell = sender as? GameViewCell
        
        gameDetailViewController.title = gameViewCell?.gameName
        gameDetailViewController.gameId = gameViewCell?.gameId
    }
}

extension GamesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameViewCell", for: indexPath) as! GameViewCell
        
        if let actualGame = viewModel?.data[indexPath.row] {
            cell.gameId = actualGame.id
            cell.gameName = actualGame.name
            cell.gameImage.load(url: actualGame.cover)
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = CGColor(red: 150 / 255.0, green: 150 / 255.0, blue: 150 / 255.0, alpha: 1)
        }
        
        return cell
    }
    
    // MARK: - FlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5
        let resultSize = (collectionView.bounds.width / columns) - 15

        return CGSize(width: resultSize, height: resultSize)
    }
}

extension GamesViewController: UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.data.removeAll()
        
        if (searchBar.text!.isEmpty) {
            viewModel?.fetchData()
        } else {
            viewModel?.fetchData(search: searchBar.text!, page: 0)
        }
        
        self.gamesCollectionView?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text!.isEmpty) {
            viewModel?.data.removeAll()
            
            viewModel?.fetchData()
        }
    }
}
