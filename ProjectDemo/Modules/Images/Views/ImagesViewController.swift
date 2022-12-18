//
//  ImagesViewController.swift
//  ProjectDemo
//
//  Created by đạt on 30/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ImagesViewController: BaseCollectionViewController<TrendingCollectionViewCell> {

    // MARK: - Properties
	var presenter: ImagesPresenterInterface!
    
    override var numberOfColumn: Int {
        return 2
    }
    
    override var spacing: Double {
        return 9
    }
    
    override var heightForItem: Double {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 256
        }
       return 95
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.popChildViewController(nil, true)
        }
        navigation.lbTitle.text = "Image"
        self.headerRefresh = {
            delay(0.5, closure: {
                self.scrollView.headRefreshControl.endRefreshing()
            })
        }
        self.footerRefresh = {
            delay(0.5, closure: {
                self.scrollView.footRefreshControl.endRefreshing()
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! TrendingCollectionViewCell
        let item = datas[indexPath.row]
        cell.configCell(item)
        return cell
    }
}

// MARK: - ImagesViewInterface
extension ImagesViewController: ImagesViewInterface {
    var datas: [Any] {
        if let urls = payload as? [Any] {
            return urls
        }
        return []
    }
}
