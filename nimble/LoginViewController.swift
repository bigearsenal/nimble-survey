//
//  LoginViewController.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class LoginViewController: BaseViewController {
    override var padding: UIEdgeInsets {.init(top: 24, left: 24, bottom: 24, right: 24)}
    
    lazy var nimbleLogo = UIImageView(width: 167, height: 40, imageNamed: "nimble_logo")
    lazy var emailField = UITextField(height: 56, backgroundColor: UIColor.white.withAlphaComponent(0.18), cornerRadius: 10, placeholder: "Email", autocorrectionType: .no, textContentType: .emailAddress, leftView: UIView(width: 12), leftViewMode: .always, rightView: UIView(width: 12), rightViewMode: .always)
    lazy var passwordField = UITextField(height: 56, backgroundColor: UIColor.white.withAlphaComponent(0.18), cornerRadius: 10, placeholder: "Password", autocorrectionType: .no, spellCheckingType: .no, isSecureTextEntry: true, horizontalPadding: 12, rightView: forgotButton.padding(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)), rightViewMode: .always)
    lazy var loginButton = UIButton(height: 56, backgroundColor: .white, cornerRadius: 10, label: "Login", labelFont: .systemFont(ofSize: 17, weight: .semibold), textColor: .black)
    lazy var forgotButton = UIButton(label: "Forgot?", textColor: UIColor.white.withAlphaComponent(0.5))
    
    override func setUp() {
        super.setUp()
        // background
        let bgImageView = UIImageView(image: UIImage(named: "Background"))
        bgImageView.configureForAutoLayout()
        view.insertSubview(bgImageView, at: 0)
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        // add anythings to stackView
        stackView.spacing = 20
        stackView.addArrangedSubview(UIView(height: 80)) // setCustomSpacing is only avalable in iOS 11, so I create 'spacer' view for spacing instead
        stackView.addArrangedSubview(nimbleLogo.centeredHorizontallyView)
        stackView.addArrangedSubview(UIView(height: 80))
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(loginButton)
        
        view.layoutIfNeeded()
//        nimbleLogo.isHidden = true
        
    }
    
    func animate() {
        let tempLogo = UIImageView(width: 201, height: 48, imageNamed: "nimble_logo")
        view.addSubview(tempLogo)
        
    }
}
