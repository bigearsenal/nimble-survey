//
//  BaseView.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

class BaseView: UIView {
    // MARK: - Class Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - Custom Functions
    func commonInit() {
        
    }
}
