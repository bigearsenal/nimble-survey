//
//  UIView+Loader.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

private var loadingHandle: UInt8 = 0

extension UIView {
    func showLoading() {
        hideLoading()
        
        // get loader
        let loaderLayer = CAGradientLayer()
        
        layoutIfNeeded()
        
        let gradientWidth = 0.17
        let gradientFirstStop = 0.1
        let loaderDuration = 0.85
        
        loaderLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width , height: self.bounds.size.height)
        self.layer.insertSublayer(loaderLayer, at:0)
        loaderLayer.startPoint = CGPoint(x: -1.0 + CGFloat(gradientWidth), y: 0)
        loaderLayer.endPoint = CGPoint(x: 1.0 + CGFloat(gradientWidth), y: 0)
        
        loaderLayer.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.24).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.48).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.24).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor
        ]
        
        let startLocations = [NSNumber(value: loaderLayer.startPoint.x.toDouble() as Double),NSNumber(value: loaderLayer.startPoint.x.toDouble() as Double),NSNumber(value: 0 as Double),NSNumber(value: gradientWidth as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        
        loaderLayer.locations = startLocations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = startLocations
        gradientAnimation.toValue = [NSNumber(value: 0 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 + (gradientWidth - gradientFirstStop) as Double),NSNumber(value: 1 + gradientWidth as Double)]
        
        gradientAnimation.repeatCount = Float.infinity
//        gradientAnimation.fillMode = .forwards
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.duration = loaderDuration
        loaderLayer.add(gradientAnimation ,forKey:"locations")
        
        // save loader
        objc_setAssociatedObject(self, &loadingHandle, loaderLayer, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func hideLoading() {
        (objc_getAssociatedObject(self, &loadingHandle) as? CAGradientLayer)?.removeFromSuperlayer()
    }
}
