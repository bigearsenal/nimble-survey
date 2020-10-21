//
//  BaseViewController.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

class BaseViewController: BEViewController {
    var padding: UIEdgeInsets { UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) }
    
    lazy var scrollView = ContentHuggingScrollView(scrollableAxis: .vertical)
    lazy var stackView = UIStackView(axis: .vertical, spacing: 10, alignment: .fill, distribution: .fill)
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .red
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTouch))
        view.addGestureRecognizer(tapGesture)
        // scroll view for flexible height
        view.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
        if #available(iOS 11, *) {
            scrollView.autoPinBottomToSuperViewSafeAreaAvoidKeyboard(inset: 16)
        } else {
            let bottomConstraint = AvoidingKeyboardLayoutConstraint(item: view.bottomAnchor, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0)
            bottomConstraint.observeKeyboardHeight()
            view.addConstraint(bottomConstraint)
        }
        
        // stackView
        scrollView.contentView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges(with: padding)
    }
    
    @objc func viewDidTouch() {
        view.endEditing(true)
    }
}
