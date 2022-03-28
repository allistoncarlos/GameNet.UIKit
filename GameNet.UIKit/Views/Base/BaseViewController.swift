//
//  BaseViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 28/03/22.
//

import UIKit

#if !PRODUCTION
import Pulse
import PulseUI
#endif

class BaseViewController: UIViewController {
#if !PRODUCTION
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            if #available(iOS 13.0, *) {
                let view = MainViewController(store: LoggerStore.default)
                present(view, animated: true, completion: nil)
            }
        }
    }
#endif
}
