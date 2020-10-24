//
//  HomeVC.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class HomeVC: BEViewController {
    override var preferredNavigationBarStype: BEViewController.NavigationBarStyle {.hidden}
    
    // MARK: - Subviews
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 26/255, alpha: 1)
    }
}
