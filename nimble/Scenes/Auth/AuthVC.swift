//
//  AuthVC.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class AuthVC: BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {.lightContent}
    override var padding: UIEdgeInsets {.init(top: 24, left: 24, bottom: 24, right: 24)}
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    lazy var nimbleLogo = UIImageView(width: 167.adaptiveHeight, height: 40.adaptiveHeight, imageNamed: "nimble_logo")
    lazy var emailField = UITextField(height: 56.adaptiveHeight, backgroundColor: UIColor.white.withAlphaComponent(0.18), cornerRadius: 10, textColor: .white, placeholder: "Email", placeholderTextColor: .white, autocorrectionType: .no, autocapitalizationType: UITextAutocapitalizationType.none, textContentType: .emailAddress, leftView: UIView(width: 12), leftViewMode: .always, rightView: UIView(width: 12), rightViewMode: .always)
    
    override func setUp() {
        super.setUp()
        // background
        let bgImageView = UIImageView(image: UIImage(named: "Background"))
        bgImageView.configureForAutoLayout()
        view.insertSubview(bgImageView, at: 0)
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        // blur effect
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        
        // add anythings to stackView
        stackView.spacing = 20
        stackView.addArrangedSubview(UIView(height: 80.adaptiveHeight)) // setCustomSpacing is only avalable in iOS 11, so I create 'spacer' view for spacing instead
        stackView.addArrangedSubview(nimbleLogo.centeredHorizontallyView)
    }
    
    func createActionButton(label: String) -> BaseButton {
        BaseButton(height: 56.adaptiveHeight, backgroundColor: .white, cornerRadius: 10, label: label, labelFont: .systemFont(ofSize: 17, weight: .semibold), textColor: .black)
    }
}
