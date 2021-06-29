//
//  UIImageViewExtensions.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/06/21.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
