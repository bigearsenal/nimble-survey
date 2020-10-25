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
    
    // MARK: - Subviews
    lazy var bgImageView = UIImageView(contentMode: .scaleAspectFill)
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl(forAutoLayout: ())
        pc.addTarget(self, action: #selector(pageControlDidChangePage), for: .touchUpInside)
        return pc
    }()
    lazy var pageCollectionView: UICollectionView = {
        let collectionView = UICollectionView.horizontalFlow(
            cellType: SurveyCell.self
        )
        collectionView.layer.masksToBounds = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
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
        
        view.addSubview(bgImageView)
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        // add pageVC
        view.addSubview(pageCollectionView)
        pageCollectionView.autoPinEdgesToSuperviewEdges()
        
        // add page controll
        view.addSubview(pageControl)
        pageControl.autoPinEdge(toSuperviewEdge: .leading, withInset: -20)
        pageControl.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 206)
        
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
        
        viewModel.dataRelay.filter {$0 != nil}.map {$0!}
            .bind(to: pageCollectionView.rx.items(cellIdentifier: "SurveyCell", cellType: SurveyCell.self)) { _, model, cell in
                cell.setUpWithSurvey(model)
            }
            .disposed(by: disposeBag)
        
        viewModel.surveys
            .subscribe(onNext: { [weak self] surveys in
                
                self?.pageControl.numberOfPages = surveys.count
                self?.moveToItemAtIndex(0)
            })
            .disposed(by: disposeBag)
        
        pageCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func setUpWithLoadingState(_ state: HomeViewModel.LoadingState) {
        errorView.isHidden = true
        switch state {
        case .loading:
            pageCollectionView.isHidden = true
            topLoadingStackView.isHidden = false
            bottomLoadingStackView.isHidden = false
            avatarLoadingImageView.isHidden = false
        case .loaded:
            pageCollectionView.isHidden = false
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
            avatarLoadingImageView.isHidden = true
        case .error(let error):
            pageCollectionView.isHidden = true
            errorView.isHidden = false
            errorLabel.text = (error as? NBError)?.localizedDescription ?? error.localizedDescription
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
            avatarLoadingImageView.isHidden = true
        }
    }
    
    func moveToItemAtIndex(_ index: Int) {
//        guard viewControllers.count > index else { return }
//        let vc = viewControllers[index]
//
//        pageVC.setViewControllers([vc], direction: index > currentPageIndex ? .forward : .reverse, animated: true, completion: nil)
//        pageControl.currentPage = index
//
//        currentPageIndex = index
    }
    
    // MARK: - Actions
    @objc func reload() {
        viewModel.reloadSubject.onNext(())
    }
    
    @objc func pageControlDidChangePage(){
        moveToItemAtIndex(pageControl.currentPage)
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

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        view.bounds.size
    }
}
