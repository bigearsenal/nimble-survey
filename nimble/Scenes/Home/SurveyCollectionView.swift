//
//  SurveyCollectionView.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

class SurveyCollectionView: UICollectionView {
    var handleRefresh: ((CGFloat) -> Void)?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(frame: .zero, collectionViewLayout: layout)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        register(SurveyCell.self, forCellWithReuseIdentifier: "\(SurveyCell.self)")
        isPagingEnabled = true
        backgroundColor = .clear
        configureForAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panGesture.velocity(in: self)
            if abs(velocity.x) < abs(velocity.y) {
                let y = panGesture.translation(in: self).y
                if y > 30 {
                    handleRefresh?(y)
                }
                return false
            }
        }
        return true
    }
}
