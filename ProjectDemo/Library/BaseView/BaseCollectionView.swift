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
        let collectionView = BaseCollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewLayout())
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
    
    func withEstimatedItemSize(_ size: CGSize) -> BaseCollectionBuilder {
        if size == UICollectionViewFlowLayout.automaticSize {
            flowLayout.estimatedItemSize = size
        }
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
    
    func withScrollDirection(_ scroll: UICollectionView.ScrollDirection) -> BaseCollectionBuilder {
        flowLayout.scrollDirection = scroll
        return self
    }
    
    func build() -> BaseCollectionView {
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.isScrollEnabled = true
        self.collectionView.collectionViewLayout.invalidateLayout()
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
