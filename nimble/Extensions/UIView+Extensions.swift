//
//  UIView+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

extension UIView {
    var heightConstraint: NSLayoutConstraint? {
        return constraints.first(where: {$0.firstAttribute == .height && $0.secondItem == nil})
    }
    var widthConstraint: NSLayoutConstraint? {
        return constraints.first(where: {$0.firstAttribute == .width && $0.secondItem == nil})
    }
    var centeredHorizontallyView: UIView {
        let view = UIView(forAutoLayout: ())
        view.addSubview(self)
        self.autoPinEdge(.top, to: .top, of: view)
        self.autoPinEdge(.bottom, to: .bottom, of: view)
        self.autoAlignAxis(toSuperviewAxis: .vertical)
        return view
    }
    
    func padding(_ inset: UIEdgeInsets) -> UIView {
        let view = UIView(forAutoLayout: ())
        view.addSubview(self)
        self.autoPinEdgesToSuperviewEdges(with: inset)
        return view
    }
    
    @discardableResult
    func onTap(_ target: Any?, action: Selector) -> Self {
        if self is UIButton {
            (self as? UIButton)?.addTarget(target, action: action, for: .touchUpInside)
            return self
        }
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        return self
    }
    
    @discardableResult
    func hidden() -> Self {
        isHidden = true
        return self
    }
}
