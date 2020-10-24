//
//  UIViewController+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation
import MBProgressHUD

extension UIWindow {
    func showIndetermineHudWithMessage(_ message: String?) {
        // Hide all previous hud
        hideHud()
        
        // show new hud
        let hud = MBProgressHUD.showAdded(to: self, animated: false)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.isUserInteractionEnabled = true
        hud.label.text = message
    }
    
    func hideHud() {
        MBProgressHUD.hide(for: self, animated: false)
    }
}

extension UIViewController {
    
    func showError(_ error: Error, completion: (() -> Void)? = nil) {
        let message = error.localizedDescription
        
        showAlert(title: "Error", message: message, buttonTitles: ["OK"]) { (_) in
            completion?()
        }
    }
    
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        view.layer.removeAllAnimations()
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}
