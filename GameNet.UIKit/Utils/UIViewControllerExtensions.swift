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
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = Constants.primaryColor
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    func setupModalNavigationBar(title: String) {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.backgroundColor = Constants.primaryColor
            navigationController.topViewController?.title = title
            navigationController.navigationBar.tintColor = .label
        }
//        else {
//            let frame = CGRect(
//                        x: 0,
//                        y: 0,
//                        width: view.frame.size.width,
//                        height: 44)
//            
//            let navigationBar = UINavigationBar(frame: frame)
//            navigationBar.backgroundColor = Constants.primaryColor
//            
//            let navigationItem = UINavigationItem(title: title)
//            navigationBar.setItems([navigationItem], animated: false)
//            view.addSubview(navigationBar)
//        }
    }
}
