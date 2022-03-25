//
//  GameViewCell.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/06/21.
//

import UIKit
import Foundation

class GameViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var gameImage: UIImageView!

    var gameId: String?
    var gameName: String?

    override func prepareForReuse() {
        self.gameImage!.image = UIImage()
    }
}
