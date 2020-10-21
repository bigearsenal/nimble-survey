//
//  LoginViewController.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class LoginViewController: BaseViewController {
    override func setUp() {
        super.setUp()
        // background
        let bgImageView = UIImageView(image: UIImage(named: "Background"))
        bgImageView.configureForAutoLayout()
        view.insertSubview(bgImageView, at: 0)
        bgImageView.autoPinEdgesToSuperviewEdges()
    }
}
