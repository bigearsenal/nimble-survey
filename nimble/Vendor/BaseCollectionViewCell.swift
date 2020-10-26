//
//  BaseCollectionViewCell.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        
    }
}
