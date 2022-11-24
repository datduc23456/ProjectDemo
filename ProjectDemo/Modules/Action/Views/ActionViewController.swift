//
//  ActionViewController.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ActionViewController: BaseCollectionViewController<CinemaPopularCollectionViewCell> {

    // MARK: - Properties
    
    override var numberOfColumn: Int {
        return 2
    }
    
    override var spacing: Double {
        return 13
    }
    
    override var heightForItem: Double {
       return 240
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.lbTitle.text = "Action"
    }
    
	var presenter: ActionPresenterInterface!
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! CinemaPopularCollectionViewCell
        return cell
    }
}

// MARK: - ActionViewInterface
extension ActionViewController: ActionViewInterface {
}
