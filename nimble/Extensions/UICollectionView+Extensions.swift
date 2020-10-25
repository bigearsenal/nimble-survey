//
//  UICollectionView+Extensions.swift
//  nimble
//
//  Created by Chung Tran on 10/25/20.
//

import Foundation

extension UICollectionView {
    static func horizontalFlow<T: UICollectionViewCell>(cellType: T.Type, contentInsets: UIEdgeInsets? = nil, backgroundColor: UIColor = .clear) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.backgroundColor = .clear
        collectionView.configureForAutoLayout()
//        collectionView.layer.masksToBounds = false
        
        collectionView.register(T.self, forCellWithReuseIdentifier: "\(T.self)")
        
        if let insets = contentInsets {
            collectionView.contentInset = insets
        }
        
        collectionView.backgroundColor = backgroundColor
        return collectionView
    }
}
