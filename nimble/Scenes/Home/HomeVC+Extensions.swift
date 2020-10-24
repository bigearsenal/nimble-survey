//
//  HomeVC+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

extension HomeVC {
    class LoadingView: BaseView {
        let defaultHeight: CGFloat = 16
        
        init(width: CGFloat) {
            super.init(frame: .zero)
            configureForAutoLayout()
            autoSetDimension(.height, toSize: defaultHeight)
            layer.cornerRadius = defaultHeight / 2
            layer.masksToBounds = true
            autoSetDimension(.width, toSize: width)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func commonInit() {
            super.commonInit()
        }
        
        func showLoading() {
            layoutIfNeeded()
            
            let gradientWidth = 0.17
            let gradientFirstStop = 0.1
            let loaderDuration = 0.85
            
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width , height: self.bounds.size.height)
            self.layer.insertSublayer(gradient, at:0)
            gradient.startPoint = CGPoint(x: -1.0 + CGFloat(gradientWidth), y: 0)
            gradient.endPoint = CGPoint(x: 1.0 + CGFloat(gradientWidth), y: 0)
            
            gradient.colors = [
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor,
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.24).cgColor,
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.48).cgColor,
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.24).cgColor,
                UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor
            ]
            
            let startLocations = [NSNumber(value: gradient.startPoint.x.toDouble() as Double),NSNumber(value: gradient.startPoint.x.toDouble() as Double),NSNumber(value: 0 as Double),NSNumber(value: gradientWidth as Double),NSNumber(value: 1 + gradientWidth as Double)]
            
            
            gradient.locations = startLocations
            let gradientAnimation = CABasicAnimation(keyPath: "locations")
            gradientAnimation.fromValue = startLocations
            gradientAnimation.toValue = [NSNumber(value: 0 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 as Double),NSNumber(value: 1 + (gradientWidth - gradientFirstStop) as Double),NSNumber(value: 1 + gradientWidth as Double)]
            
            gradientAnimation.repeatCount = Float.infinity
    //        gradientAnimation.fillMode = .forwards
            gradientAnimation.isRemovedOnCompletion = false
            gradientAnimation.duration = loaderDuration
            gradient.add(gradientAnimation ,forKey:"locations")
        }
    }
}
