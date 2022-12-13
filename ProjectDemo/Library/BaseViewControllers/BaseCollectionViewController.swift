//
//  BaseCollectionViewController.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 25/11/2022.
//

import UIKit
import KafkaRefresh

class BaseCollectionViewController<T: UICollectionViewCell>: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: BaseCollectionView!
    var page: Int = 1
    var headerRefresh: VoidCallBack?
    var footerRefresh: VoidCallBack?
    
    var numberOfColumn: Int {
        return 3
    }
    
    var spacing: Double {
        return 12
    }
    
    var heightForItem: Double {
        return 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if numberOfColumn == 0 {
            self.collectionView = BaseCollectionBuilder().withCell(T.self)
                .withScrollDirection(.vertical)
                .withEstimatedItemSize(UICollectionViewFlowLayout.automaticSize)
                .withSpacingInRow(spacing)
                .withSpacingInGrid(spacing)
                .build()
        } else {
            self.collectionView = BaseCollectionBuilder().withCell(T.self)
                .withScrollDirection(.vertical)
                .withSpacingInRow(spacing)
                .withSpacingInGrid(spacing)
                .build()
        }
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        self.collectionView.register(ofType: SmallNativeAdCollectionViewCell.self)
        self.collectionView.registerCell(for: T.className)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.bindHeadRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            self.page = 1
            self.headerRefresh?()
        }, themeColor: .white, refreshStyle: .replicatorCircle)
        
        self.collectionView.bindFootRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            self.page += 1
            self.footerRefresh?()
        }, themeColor: .white, refreshStyle: .replicatorCircle)
        
        self.collectionView.headRefreshControl.layoutIfNeeded()
        self.collectionView.headRefreshControl.presetContentInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if numberOfColumn == 0 {
            return CGSize(width: 1, height: 1)
        }
        let spacing = self.spacing * Double(numberOfColumn - 1)
        let widthForItem = (collectionView.bounds.width - spacing) / Double(numberOfColumn)
        return CGSize.init(width: widthForItem, height: heightForItem)
    }
}
