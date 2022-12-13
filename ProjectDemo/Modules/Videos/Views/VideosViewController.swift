//
//  VideosViewController.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class VideosViewController: BaseCollectionViewController<TrendingCollectionViewCell> {
    
    // MARK: - Properties
    var presenter: VideosPresenterInterface!
    
    override var numberOfColumn: Int {
        return 2
    }
    
    override var spacing: Double {
        return 9
    }
    
    override var heightForItem: Double {
       return 95
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.popChildViewController(nil, true)
        }
        navigation.lbTitle.text = "Videos"
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
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeue(ofType: SmallNativeAdCollectionViewCell.self, indexPath: indexPath)
            cell.adView.register(id: "")
            return cell
        }
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! TrendingCollectionViewCell
        let item = videos[indexPath.row]
        cell.configCell(item)
        cell.didTapAction = { [weak self] _ in
            guard let `self` = self else { return }
            self.presenter.didTapPlayVideo(item)
        }
        return cell
    }
}

// MARK: - VideosViewInterface
extension VideosViewController: VideosViewInterface {
    var videos: [Video] {
        if let videos = payload as? [Video] {
            return [Video()] + videos
        }
        return []
    }
}
