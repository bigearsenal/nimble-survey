//
//  HomeVC.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class HomeVC: BEViewController {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    
    // MARK: - Subviews
    lazy var imageView = UIImageView(forAutoLayout: ())
        .hidden()
    
    lazy var topLoadingStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: 10, alignment: .leading, distribution: .fill)
        stackView.addArrangedSubview(LoadingView(width: 117))
        stackView.addArrangedSubview(LoadingView(width: 100))
        return stackView
    }()
    
    lazy var bottomLoadingStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: 0, alignment: .leading, distribution: .fill)
        stackView.addArrangedSubview(LoadingView(width: 40))
        stackView.addArrangedSubview(UIView(height: 16))
        stackView.addArrangedSubview(LoadingView(width: 254))
        stackView.addArrangedSubview(UIView(height: 8))
        stackView.addArrangedSubview(LoadingView(width: 127))
        stackView.addArrangedSubview(UIView(height: 16))
        stackView.addArrangedSubview(LoadingView(width: 318))
        stackView.addArrangedSubview(UIView(height: 8))
        stackView.addArrangedSubview(LoadingView(width: 212))
        return stackView
    }()
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 26/255, alpha: 1)
        view.addSubview(imageView)
        
        view.addSubview(bottomLoadingStackView)
        bottomLoadingStackView.autoPinToTopLeftCornerOfSuperviewSafeArea(xInset: 20, yInset: 17)
        bottomLoadingStackView.arrangedSubviews.forEach {($0 as? LoadingView)?.showLoading()}
    }
}
