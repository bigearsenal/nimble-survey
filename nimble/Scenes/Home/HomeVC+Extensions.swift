//
//  HomeVC+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

extension HomeVC {
    class LoadingView: BaseView {
        let defaultHeight: CGFloat = 12
        
        init(width: CGFloat) {
            super.init(frame: .zero)
            configureForAutoLayout()
            autoSetDimension(.height, toSize: defaultHeight)
            layer.cornerRadius = defaultHeight
            layer.masksToBounds = true
            autoSetDimension(.width, toSize: width)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func commonInit() {
            super.commonInit()
        }
    }
}
