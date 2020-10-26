//
//  CGFloat+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import Foundation

extension CGFloat {
    // iPhone X as design template
    static let heightRatio: CGFloat = UIScreen.main.bounds.height / (UIApplication.shared.statusBarOrientation.isPortrait ? 812 : 375)
    static let widthRatio: CGFloat = UIScreen.main.bounds.width / (UIApplication.shared.statusBarOrientation.isPortrait ? 375 : 812)
    
    func toDouble()->Double
    {
        return Double(self)
    }
}

extension BinaryInteger {
    
    var adaptiveWidth: CGFloat {
        (CGFloat(self) * CGFloat.widthRatio).rounded(.down)
    }

    var adaptiveHeight: CGFloat {
        (CGFloat(self) * CGFloat.heightRatio).rounded(.down)
    }
}
