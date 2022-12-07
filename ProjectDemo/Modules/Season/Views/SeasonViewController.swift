//
//  SeasonViewController.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SeasonViewController: BaseCollectionViewController<TVShowCollectionViewCell> {

    // MARK: - Properties
	var presenter: SeasonPresenterInterface!
    
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
        navigation.btnBack.addTapGestureRecognizer {
            self.popChildViewController(nil, true)
        }
        navigation.lbTitle.text = "Season"
        self.headerRefresh = {
            delay(0.5, closure: {
                self.collectionView.headRefreshControl.endRefreshing()
            })
        }
        self.footerRefresh = {
            delay(0.5, closure: {
                self.collectionView.footRefreshControl.endRefreshing()
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! TVShowCollectionViewCell
        let item = seasons[indexPath.row]
        cell.configCell(item, isTVShowDetail: true)
        return cell
    }
}

// MARK: - SeasonViewInterface
extension SeasonViewController: SeasonViewInterface {
    var seasons: [Season] {
        if let seasons = payload as? [Season] {
            return seasons
        }
        return []
    }
}
