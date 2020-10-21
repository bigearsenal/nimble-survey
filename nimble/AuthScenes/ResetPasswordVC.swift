//
//  ResetPasswordVC.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class ResetPasswordVC: AuthVC {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.normal(translucent: true, backgroundColor: .clear, textColor: .white)}
    lazy var resetButton = createActionButton(label: "Reset")
    
    override func setUp() {
        super.setUp()
        let descriptionLabel = UILabel(text: "Enter your email to receive instructions for resetting your password.", textSize: 17, textColor: .white, numberOfLines: 0, textAlignment: .center)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(UIView(height: 76.adaptiveHeight))
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(resetButton)
    }
    
    override func bind() {
        super.bind()
    }
    
}
