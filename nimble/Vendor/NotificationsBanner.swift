//
//  NotificationsBanner.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

class NotificationBanner: BaseView {
    lazy var titleLabel = UILabel(textSize: 15, weight: .bold, textColor: .white, numberOfLines: 0)
    lazy var messageLabel = UILabel(textSize: 13, textColor: .white, numberOfLines: 0)
    
    override func commonInit() {
        super.commonInit()
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        addSubview(blurEffectView)
        blurEffectView.autoPinEdgesToSuperviewEdges()
        
        let stackView = UIStackView(axis: .horizontal, spacing: 10, alignment: .top, distribution: .fill)
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 16))
        
        stackView.addArrangedSubview(UIImageView(width: 23, height: 23, imageNamed: "notifications-bell"))
        
        let vStackView: UIStackView = {
            let stackView = UIStackView(axis: .vertical, spacing: 0, alignment: .fill, distribution: .fill)
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(messageLabel)
            return stackView
        }()
        
        stackView.addArrangedSubview(vStackView)
    }
    
    func setUp(title: String?, message: String) {
        titleLabel.isHidden = title == nil
        titleLabel.text = title
        messageLabel.text = message
    }
    
    // Show in keywindow
    static func show(in view: UIView? = UIApplication.shared.keyWindow, title: String?, message: String, dismissAfter duration: TimeInterval = 1) {
        guard let view = view else {return}
        let banner = NotificationBanner(forAutoLayout: ())
        view.addSubview(banner)
        banner.autoPinEdge(toSuperviewEdge: .top)
        if UIDevice.current.userInterfaceIdiom == .pad {
            banner.autoAlignAxis(toSuperviewAxis: .vertical)
            banner.autoSetDimension(.width, toSize: 116)
        } else {
            banner.autoPinEdge(toSuperviewEdge: .leading)
            banner.autoPinEdge(toSuperviewEdge: .trailing)
        }
        banner.setUp(title: title, message: message)
        banner.setNeedsLayout()
        view.layoutIfNeeded()
        let originalTransform = banner.transform
        let hiddenTransform = originalTransform.translatedBy(x: 0, y: -banner.bounds.size.height)
        banner.transform = hiddenTransform
        banner.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            banner.alpha = 1
            banner.transform = originalTransform
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: duration) {
                banner.alpha = 0
                banner.transform = hiddenTransform
            } completion: { _ in
                banner.removeFromSuperview()
            }
        }
    }
}
