//
//  LoginViewController.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class LoginVC: AuthVC {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    
    // MARK: - Subviews
    lazy var passwordField = UITextField(height: 56.adaptiveHeight, backgroundColor: UIColor.white.withAlphaComponent(0.18), cornerRadius: 10, textColor: .white, placeholder: "Password", placeholderTextColor: .white, autocorrectionType: .no, spellCheckingType: .no, isSecureTextEntry: true, horizontalPadding: 12, rightView: forgotButton.padding(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)), rightViewMode: .always)
    lazy var loginButton = createActionButton(label: "Login")
    lazy var forgotButton = UIButton(label: "Forgot?", textColor: UIColor.white.withAlphaComponent(0.5))
        .onTap(self, action: #selector(buttonForgotDidTouch))
    
    // MARK: - Methods
    override func setUp() {
        super.setUp()
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
    
    // MARK: - Actions
    @objc func buttonForgotDidTouch() {
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let vc = ResetPasswordVC()
            self.show(vc, sender: nil)
        }
    }
    
    // MARK: - Helpers
    func animate() {
        // prepare
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
            self.blurEffectView.alpha = 1
            self.emailField.alpha = 1
            self.passwordField.alpha = 1
            self.loginButton.alpha = 1
        } completion: { (_) in
            self.emailField.becomeFirstResponder()
        }
    }
}
