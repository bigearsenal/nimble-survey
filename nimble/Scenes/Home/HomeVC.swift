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
    lazy var loadingView = UIImageView(width: 36, height: 36, cornerRadius: 18, imageNamed: "loading")
    lazy var bgImageView = UIImageView(contentMode: .scaleAspectFill)
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl(forAutoLayout: ())
        pc.isUserInteractionEnabled = false
        pc.addTarget(self, action: #selector(pageControlDidChangePage), for: .touchUpInside)
        return pc
    }()
    lazy var pageCollectionView = SurveyCollectionView()
    
    lazy var avatarImageView = UIImageView(width: 36, height: 36, cornerRadius: 18)
        .onTap(self, action: #selector(avatarButtonDidTouch))
    lazy var topLoadingStackView = createTopLoadingView()
    lazy var bottomLoadingStackView = createBottomLoadingView()
    
    lazy var errorView = createErrorView()
    lazy var errorLabel = UILabel(textSize: 17, weight: .medium, textColor: .white, numberOfLines: 0, textAlignment: .center)
    
    // MARK: - Methods
    override func setUp() {
        super.setUp()
        // background
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 26/255, alpha: 1)
        
        // background image
        view.addSubview(bgImageView)
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        view.layoutIfNeeded()
        
        let gradView = UIView(frame: bgImageView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = gradView.frame
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        gradView.layer.insertSublayer(gradient, at: 0)

        bgImageView.addSubview(gradView)
        bgImageView.bringSubviewToFront(gradView)
        
        // pageCollectionView with pull to refresh
        view.addSubview(pageCollectionView)
        pageCollectionView.autoPinEdgesToSuperviewEdges()
        
        // add page controll
        view.addSubview(pageControl)
        pageControl.autoPinEdge(toSuperviewEdge: .leading, withInset: -20)
        pageControl.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 206 - 18)
        
        // add loading views
        addLoadingViews()
        
        // avatar
        view.addSubview(avatarImageView)
        avatarImageView.autoPinToTopRightCornerOfSuperviewSafeArea(xInset: 20, yInset: 35)
        
        // pull to refresh
        view.addSubview(loadingView)
        loadingView.isHidden = true
        loadingView.autoAlignAxis(toSuperviewAxis: .vertical)
        loadingView.autoPinEdge(.top, to: .bottom, of: avatarImageView, withOffset: 26)
        
        pageCollectionView.handleRefresh = { y in
            self.loadingView.isHidden = false
            self.loadingView.layer.removeAllAnimations()
            let anim = CABasicAnimation(keyPath: "transform.rotation.z")
            anim.duration = 0.3
            anim.repeatCount = 3
            anim.fromValue = 0
            anim.toValue = CGFloat.pi * 2
            anim.delegate = self
            anim.isRemovedOnCompletion = false
            self.loadingView.layer.add(anim, forKey: "reload")
        }
        
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
        
        viewModel.userRelay.filter {$0 != nil}
            .map {$0!.avatar_url}
            .subscribe(onNext: { [weak self] url in
                guard let self = self, let urlString = url, let url = URL(string: urlString) else {return}
                self.avatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "user-default-avatar"))
            })
            .disposed(by: disposeBag)
        
        // handle scroll view
        pageCollectionView.rx.didEndDecelerating
            .subscribe(onNext: {
                let pageWidth = self.pageCollectionView.frame.size.width
                let currentPage = Int((self.pageCollectionView.contentOffset.x + pageWidth / 2) / pageWidth)
                self.moveToItemAtIndex(currentPage)
            })
            .disposed(by: disposeBag)
        
        pageCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func setUpWithLoadingState(_ state: HomeViewModel.LoadingState) {
        errorView.isHidden = true
        avatarImageView.isHidden = false
        switch state {
        case .loading:
            pageCollectionView.isHidden = true
            topLoadingStackView.isHidden = false
            bottomLoadingStackView.isHidden = false
            avatarImageView.showLoading()
            pageControl.isHidden = true
        case .loaded:
            pageCollectionView.isHidden = false
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
            avatarImageView.hideLoading()
            pageControl.isHidden = false
        case .error(let error):
            pageCollectionView.isHidden = true
            errorView.isHidden = false
            errorLabel.text = (error as? NBError)?.localizedDescription ?? error.localizedDescription
            topLoadingStackView.isHidden = true
            bottomLoadingStackView.isHidden = true
            avatarImageView.isHidden = true
            pageControl.isHidden = true
        }
    }
    
    func moveToItemAtIndex(_ index: Int) {
        guard viewModel.dataRelay.value?.count ?? 0 > index else {return}
        let item = viewModel.dataRelay.value![index]
        bgImageView.image = nil
        bgImageView.sd_setImage(with: URL(string: item.cover_image_url ?? ""))
        pageControl.currentPage = index
    }
    
    // MARK: - Actions
    @objc func reload() {
        viewModel.reload()
    }
    
    @objc func pageControlDidChangePage(){
        moveToItemAtIndex(pageControl.currentPage)
    }
    
    @objc func avatarButtonDidTouch() {
        showActionSheet(title: "Options", actions: [UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.viewModel.logOut()
        })])
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

extension HomeVC: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == loadingView.layer.animation(forKey: "reload") {
            reload()
            loadingView.isHidden = true
        }
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        view.bounds.size
    }
}
