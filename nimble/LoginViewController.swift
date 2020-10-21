//
//  LoginViewController.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class LoginViewController: BaseViewController {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    override var padding: UIEdgeInsets {.init(top: 24, left: 24, bottom: 24, right: 24)}
    
    // MARK: - Subviews
    lazy var nimbleLogo = UIImageView(width: 167.adaptiveHeight, height: 40.adaptiveHeight, imageNamed: "nimble_logo")
    lazy var emailField = UITextField(height: 56.adaptiveHeight, backgroundColor: UIColor.white.withAlphaComponent(0.18), cornerRadius: 10, placeholder: "Email", autocorrectionType: .no, autocapitalizationType: UITextAutocapitalizationType.none, textContentType: .emailAddress, leftView: UIView(width: 12), leftViewMode: .always, rightView: UIView(width: 12), rightViewMode: .always)
    lazy var passwordField = UITextField(height: 56.adaptiveHeight, backgroundColor: UIColor.white.withAlphaComponent(0.18), cornerRadius: 10, placeholder: "Password", autocorrectionType: .no, spellCheckingType: .no, isSecureTextEntry: true, horizontalPadding: 12, rightView: forgotButton.padding(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)), rightViewMode: .always)
    lazy var loginButton = UIButton(height: 56.adaptiveHeight, backgroundColor: .white, cornerRadius: 10, label: "Login", labelFont: .systemFont(ofSize: 17, weight: .semibold), textColor: .black)
    lazy var forgotButton = UIButton(label: "Forgot?", textColor: UIColor.white.withAlphaComponent(0.5))
    
    // MARK: - Methods
    override func setUp() {
        super.setUp()
        // background
        let bgImageView = UIImageView(image: UIImage(named: "Background"))
        bgImageView.configureForAutoLayout()
        view.insertSubview(bgImageView, at: 0)
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        // add anythings to stackView
        stackView.spacing = 20
        stackView.addArrangedSubview(UIView(height: 80.adaptiveHeight)) // setCustomSpacing is only avalable in iOS 11, so I create 'spacer' view for spacing instead
        stackView.addArrangedSubview(nimbleLogo.centeredHorizontallyView)
        stackView.addArrangedSubview(UIView(height: 80.adaptiveHeight))
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(loginButton)
        
        view.layoutIfNeeded()
        
        animate()
    }
    
    override func bind() {
        super.bind()
        
    }
    
    // MARK: - Helpers
    func animate() {
        // prepare
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        
        blurEffectView.alpha = 0
        emailField.alpha = 0
        passwordField.alpha = 0
        loginButton.alpha = 0
        
        let originalTransform = nimbleLogo.transform
        let originalCenter = nimbleLogo.center
        
        let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
        nimbleLogo.transform = scaledTransform
        nimbleLogo.center = stackView.convert(stackView.center, from:scrollView.contentView)
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.nimbleLogo.transform = originalTransform
            self.nimbleLogo.center = originalCenter
            blurEffectView.alpha = 1
            self.emailField.alpha = 1
            self.passwordField.alpha = 1
            self.loginButton.alpha = 1
        } completion: { (_) in
            
        }
    }
}
