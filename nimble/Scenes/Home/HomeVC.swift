//
//  HomeVC.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class HomeVC: BEViewController {
    let loadingTag = 777
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    
    // MARK: - Subviews
    lazy var bgImageView = UIImageView(forAutoLayout: ())
    lazy var avatarImageView = UIImageView(width: 36, height: 36, cornerRadius: 18)
    
    lazy var topLoadingStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: 10, alignment: .leading, distribution: .fill)
        stackView.addArrangedSubview(createLoadingView(width: 117).setTag(loadingTag))
        stackView.addArrangedSubview(createLoadingView(width: 100).setTag(loadingTag))
        return stackView
    }()
    
    lazy var bottomLoadingStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: 0, alignment: .leading, distribution: .fill)
        stackView.addArrangedSubview(createLoadingView(width: 40).setTag(loadingTag))
        stackView.addArrangedSubview(UIView(height: 16))
        stackView.addArrangedSubview(createLoadingView(width: 254).setTag(loadingTag))
        stackView.addArrangedSubview(UIView(height: 8))
        stackView.addArrangedSubview(createLoadingView(width: 127).setTag(loadingTag))
        stackView.addArrangedSubview(UIView(height: 16))
        stackView.addArrangedSubview(createLoadingView(width: 318).setTag(loadingTag))
        stackView.addArrangedSubview(UIView(height: 8))
        stackView.addArrangedSubview(createLoadingView(width: 212).setTag(loadingTag))
        return stackView
    }()
    
    override func setUp() {
        super.setUp()
        // background
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 26/255, alpha: 1)
        view.addSubview(bgImageView)
        
        // header stackView
        let headerStackView: UIStackView = {
            let stackView = UIStackView(axis: .horizontal, spacing: 10, alignment: .center, distribution: .fill)
//            stackView.addArrangedSubview(topLoadingStackView)
            stackView.addArrangedSubview(UIView(forAutoLayout: ()))
            stackView.addArrangedSubview(avatarImageView)
            return stackView
        }()
        
        view.addSubview(headerStackView)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        headerStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        view.addSubview(topLoadingStackView)
        topLoadingStackView.autoPinToTopLeftCornerOfSuperviewSafeArea(xInset: 20, yInset: 16)
        
        view.addSubview(bottomLoadingStackView)
        bottomLoadingStackView.autoPinToBottomLeftCornerOfSuperviewSafeArea(xInset: 20, yInset: 33)
    }
    
    func showLoader() {
        bgImageView.isHidden = true
        topLoadingStackView.isHidden = false
        topLoadingStackView.arrangedSubviews.filter {$0.tag == loadingTag}.forEach {$0.showLoading()}
        avatarImageView.showLoading()
        bottomLoadingStackView.isHidden = false
        bottomLoadingStackView.arrangedSubviews.filter {$0.tag == loadingTag}.forEach {$0.showLoading()}
    }
    
    func hideLoader() {
        bgImageView.isHidden = false
        topLoadingStackView.isHidden = true
        avatarImageView.hideLoading()
        bottomLoadingStackView.isHidden = true
    }
    
    // MARK: - Helpers
    private func createLoadingView(width: CGFloat) -> UIView {
        UIView(width: width, height: 16, cornerRadius: 8)
    }
}
