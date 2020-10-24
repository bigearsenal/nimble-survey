//
//  NBButton.swift
//  nimble
//
//  Created by Chung Tran on 10/24/20.
//

import Foundation

class BaseButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1: 0.5
        }
    }
}
