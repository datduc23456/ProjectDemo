//
//  BaseCollectionViewController.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 25/11/2022.
//

import UIKit

class BaseCollectionViewController<T: UICollectionViewCell>: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: BaseCollectionView!
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
        self.collectionView = BaseCollectionBuilder().withCell(T.self)
            .withScrollDirection(.vertical)
            .withSpacingInRow(spacing)
            .withSpacingInGrid(spacing)
            .build()
        self.view.addSubview(collectionView)
        self.collectionView.fillToSuperView()
        self.collectionView.registerCell(for: T.className)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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
        let spacing = self.spacing * Double(numberOfColumn + 1)
        let widthForItem = (collectionView.bounds.width - spacing) / Double(numberOfColumn)
        return CGSize.init(width: widthForItem, height: heightForItem)
    }
}
