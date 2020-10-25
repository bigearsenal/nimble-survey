//
//  HomeVC.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import SDWebImage

class HomeVC: BaseViewController {
    let loadingTag = 777
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    
    lazy var viewModel = HomeViewModel(sdk: NimbleSurveySDK.shared)
    
    // MARK: - Subviews
    lazy var avatarLoadingImageView = UIImageView(width: 36, height: 36, cornerRadius: 18)
    lazy var topLoadingStackView = createTopLoadingView()
    lazy var bottomLoadingStackView = createBottomLoadingView()
    
    lazy var errorView = createErrorView()
    lazy var errorLabel = UILabel(textSize: 17, weight: .medium, textColor: .white, numberOfLines: 0, textAlignment: .center)
    
    override func setUp() {
        super.setUp()
        // background
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 26/255, alpha: 1)
        
        // add loading views
        addLoadingViews()
        
        // load data
        reload()
    }
    
    override func bind() {
        super.bind()
        viewModel.loadingStateRelay
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] loadingState in
                self?.setUpWithLoadingState(loadingState)
            })
            .disposed(by: disposeBag)
    }
    
    func setUpWithLoadingState(_ state: HomeViewModel.LoadingState) {
        errorView.isHidden = true
        switch state {
        case .loading:
            topLoadingStackView.isHidden = false
            bottomLoadingStackView.isHidden = false
        case .loaded:
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
        case .error(let error):
            errorView.isHidden = false
            errorLabel.text = (error as? NBError)?.localizedDescription ?? error.localizedDescription
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
        }
    }
    
    // MARK: - Actions
    @objc func reload() {
        viewModel.reloadSubject.onNext(())
    }
    
    // MARK: - Helpers
    private func createLoadingView(width: CGFloat) -> UIView {
        UIView(width: width, height: 16, cornerRadius: 8)
    }
    
    private func createTopLoadingView() -> UIStackView {
        let stackView = UIStackView(axis: .vertical, spacing: 10, alignment: .leading, distribution: .fill)
        stackView.addArrangedSubview(createLoadingView(width: 117).setTag(loadingTag))
        stackView.addArrangedSubview(createLoadingView(width: 100).setTag(loadingTag))
        return stackView
    }
    
    private func createBottomLoadingView() -> UIStackView {
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
    }
    
    private func createErrorView() -> UIStackView {
        let stackView = UIStackView(axis: .vertical, spacing: 10, alignment: .center, distribution: .fill)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(
            UIButton(backgroundColor: .white, cornerRadius: 10, label: "retry", textColor: .black, contentInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
                .onTap(self, action: #selector(reload))
        )
        return stackView
    }
    
    private func addLoadingViews() {
        view.addSubview(topLoadingStackView)
        topLoadingStackView.autoPinToTopLeftCornerOfSuperviewSafeArea(xInset: 20, yInset: 16)
        topLoadingStackView.arrangedSubviews.filter {$0.tag == loadingTag}.forEach {$0.showLoading()}
        
        view.addSubview(bottomLoadingStackView)
        bottomLoadingStackView.autoPinToBottomLeftCornerOfSuperviewSafeArea(xInset: 20, yInset: 33)
        bottomLoadingStackView.arrangedSubviews.filter {$0.tag == loadingTag}.forEach {$0.showLoading()}
    }
}
