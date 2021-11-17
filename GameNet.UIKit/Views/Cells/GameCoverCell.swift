//
//  GameCoverCell.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 19/10/21.
//

import UIKit
import SwiftyFORM

protocol SelectImageDelegate {
    func didTapSelect()
}

class GameCoverCell: UITableViewCell, CellHeightProvider {
    var selectImageDelegate: SelectImageDelegate?
    
    @IBOutlet weak var cover: UIImageView!
    
    var xibHeight: CGFloat = 275
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapImageView(_:)))
        
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    static func createCell() throws -> GameCoverCell {
        let cell: GameCoverCell = try Bundle.main.form_loadView("GameCoverCell")
        return cell
    }

    func form_cellHeight(indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        xibHeight
    }
    
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        selectImageDelegate?.didTapSelect()
    }
    
    func didSelect(image: UIImage) {
        
    }
}
