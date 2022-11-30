//
//  ImagesViewController.swift
//  ProjectDemo
//
//  Created by đạt on 30/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ImagesViewController: BaseCollectionViewController<TVShowCollectionViewCell> {

    // MARK: - Properties
	var presenter: ImagesPresenterInterface!
    
    override var numberOfColumn: Int {
        return 2
    }
    
    override var spacing: Double {
        return 9
    }
    
    override var heightForItem: Double {
       return 153
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.lbTitle.text = "Season"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! TVShowCollectionViewCell
        return cell
    }
}

// MARK: - ImagesViewInterface
extension ImagesViewController: ImagesViewInterface {
}
