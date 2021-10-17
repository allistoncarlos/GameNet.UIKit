//
//  EditPlatformViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/10/21.
//

import Foundation
import UIKit

class EditPlatformViewController: UIViewController {
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let frame = CGRect(
                    x: 0,
                    y: 0,
                    width: view.frame.size.width,
                    height: 44)
        let navigationBar = UINavigationBar(frame: frame)
        navigationBar.backgroundColor = Constants.primaryColor
        let navigationItem = UINavigationItem(title: Constants.editPlatformViewTitle)
        navigationBar.setItems([navigationItem], animated: false)
        view.addSubview(navigationBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
