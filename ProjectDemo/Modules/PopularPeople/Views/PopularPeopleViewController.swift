//
//  PopularPeopleViewController.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class PopularPeopleViewController: BaseCollectionViewController<PeoplePopularCollectionViewCell> {

    // MARK: - Properties
	var presenter: PopularPeoplePresenterInterface!
    
    override var heightForItem: Double {
       return 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.lbTitle.text = "Popular People"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! PeoplePopularCollectionViewCell
        return cell
    }
}

// MARK: - PopularPeopleViewInterface
extension PopularPeopleViewController: PopularPeopleViewInterface {
}
