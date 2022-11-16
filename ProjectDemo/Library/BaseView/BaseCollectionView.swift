//
//  BaseCollectionView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 16/11/2022.
//

import UIKit

protocol FactoryUICollectionView {
    static func createWith<T: UICollectionViewCell>(_ type: T.Type) -> Self
}

extension FactoryUICollectionView where Self: BaseCollectionView {
    static func createWith<T: UICollectionViewCell>(_ type: T.Type) -> Self {
        let collectionView = BaseCollectionView()
        collectionView.registerCell(for: T.className)
        return collectionView as! Self
    }
}

class BaseCollectionBuilder {
    
    private var collectionView: BaseCollectionView!
    private var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    func withCell<T: UICollectionViewCell>(_ type: T.Type) -> BaseCollectionBuilder {
        self.collectionView = BaseCollectionView.createWith(T.self)
        return self
    }
    
    func withItemSize(_ size: CGSize) -> BaseCollectionBuilder {
        flowLayout.itemSize = size
        return self
    }
    
    func withEstimatedItemSize(_ size: CGSize) -> BaseCollectionBuilder {
        flowLayout.estimatedItemSize = size
        return self
    }
    
    func withSpacingInRow(_ spacing: CGFloat) -> BaseCollectionBuilder {
        flowLayout.minimumInteritemSpacing = spacing
        return self
    }
    
    func withSpacingInGrid(_ spacing: CGFloat) -> BaseCollectionBuilder {
        flowLayout.minimumLineSpacing = spacing
        return self
    }
    
    func withFooterReferenceSize(_ size: CGSize) -> BaseCollectionBuilder {
        flowLayout.footerReferenceSize = size
        return self
    }
    
    func withHeaderReferenceSize(_ size: CGSize) -> BaseCollectionBuilder {
        flowLayout.headerReferenceSize = size
        return self
    }
    
    func build() -> BaseCollectionView {
        self.collectionView.collectionViewLayout = flowLayout
        return self.collectionView
    }
}

class BaseCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseCollectionView: FactoryUICollectionView {}
