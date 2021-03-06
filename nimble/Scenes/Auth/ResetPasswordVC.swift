//
//  ResetPasswordVC.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation
import RxCocoa

class ResetPasswordVC: AuthVC {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.normal(translucent: true, backgroundColor: .clear, textColor: .white)}
    lazy var resetButton = createActionButton(label: "Reset")
        .onTap(self, action: #selector(resetButtonDidTouch))
    
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
        emailField.rx.text.orEmpty
            .map {NSPredicate.email.evaluate(with: $0)}
            .asDriver(onErrorJustReturn: false)
            .drive(resetButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @objc func resetButtonDidTouch() {
        UIApplication.shared.keyWindow?.showIndetermineHudWithMessage("Sending request...")
        NimbleSurveySDK.shared.resetPassword(email: emailField.text!)
            .subscribe { (message) in
                UIApplication.shared.keyWindow?.hideHud()
                NotificationBanner.show(title: "Check your email", message: message, dismissAfter: 3)
                // TODO: show notification panel
            } onError: { (error) in
                UIApplication.shared.keyWindow?.hideHud()
            }
            .disposed(by: disposeBag)
    }
}
