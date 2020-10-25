//
//  HomeVC.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation
import SDWebImage

class HomeVC: BaseViewController {
    // MARK: - Constant
    let loadingTag = 777
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    
    // MARK: - Properties
    lazy var viewModel = HomeViewModel(sdk: NimbleSurveySDK.shared)
    var currentPageIndex = 0
    var viewControllers = [SurveyVC]()
    var pageControllerBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    lazy var pageControl = UIPageControl(forAutoLayout: ())
    lazy var containerView = UIView(forAutoLayout: ())
    lazy var pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    lazy var avatarLoadingImageView = UIImageView(width: 36, height: 36, cornerRadius: 18)
    lazy var topLoadingStackView = createTopLoadingView()
    lazy var bottomLoadingStackView = createBottomLoadingView()
    
    lazy var errorView = createErrorView()
    lazy var errorLabel = UILabel(textSize: 17, weight: .medium, textColor: .white, numberOfLines: 0, textAlignment: .center)
    
    // MARK: - Methods
    override func setUp() {
        super.setUp()
        // background
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 26/255, alpha: 1)
        
        // add pageVC
        view.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewEdges()
        addChild(pageVC)
        pageVC.view.configureForAutoLayout()
        containerView.addSubview(pageVC.view)
        pageVC.view.autoPinEdgesToSuperviewEdges()
        pageVC.didMove(toParent: self)
        
        // add page controll
        view.addSubview(pageControl)
        pageControl.autoPinEdge(toSuperviewEdge: .leading, withInset: -20)
        
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
        
        viewModel.surveys
            .subscribe(onNext: { [weak self] surveys in
                self?.viewControllers = surveys.map { survey -> SurveyVC in
                    let vc = SurveyVC()
                    vc.setUpWithSurvey(survey)
                    return vc
                }
                self?.pageControl.numberOfPages = surveys.count
                self?.moveToItemAtIndex(0)
            })
            .disposed(by: disposeBag)
    }
    
    func setUpWithLoadingState(_ state: HomeViewModel.LoadingState) {
        errorView.isHidden = true
        switch state {
        case .loading:
            topLoadingStackView.isHidden = false
            bottomLoadingStackView.isHidden = false
            avatarLoadingImageView.isHidden = false
        case .loaded:
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
            avatarLoadingImageView.isHidden = true
        case .error(let error):
            errorView.isHidden = false
            errorLabel.text = (error as? NBError)?.localizedDescription ?? error.localizedDescription
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
            avatarLoadingImageView.isHidden = true
        }
    }
    
    func moveToItemAtIndex(_ index: Int) {
        guard viewControllers.count > index else { return }
        let vc = viewControllers[index]
        
        pageVC.setViewControllers([vc], direction: index > currentPageIndex ? .forward : .reverse, animated: true, completion: nil)
        pageControl.currentPage = index
        
        currentPageIndex = index
        
        // layout pageController
        pageControllerBottomConstraint?.isActive = false
        pageControllerBottomConstraint = pageControl.autoPinEdge(.bottom, to: .top, of: vc.titleLabel, withOffset: -26)

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
        
        view.addSubview(avatarLoadingImageView)
        avatarLoadingImageView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        avatarLoadingImageView.autoAlignAxis(.horizontal, toSameAxisOf: topLoadingStackView)
        avatarLoadingImageView.showLoading()
    }
}
