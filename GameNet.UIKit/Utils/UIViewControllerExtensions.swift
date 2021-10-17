//
//  UIViewControllerExtensions.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 16/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    func setupStatusBar() {
        let statusBarFrame = self.view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = Constants.primaryColor
        view.superview?.addSubview(statusBarView)
    }
    
    func setupModalNavigationBar(title: String) {
        let frame = CGRect(
                    x: 0,
                    y: 0,
                    width: view.frame.size.width,
                    height: 44)
        let navigationBar = UINavigationBar(frame: frame)
        navigationBar.backgroundColor = Constants.primaryColor
        let navigationItem = UINavigationItem(title: title)
        navigationBar.setItems([navigationItem], animated: false)
        view.addSubview(navigationBar)
    }
}
