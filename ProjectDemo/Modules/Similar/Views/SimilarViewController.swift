//
//  SimilarViewController.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SimilarViewController: BaseCollectionViewController<CinemaPopularCollectionViewCell> {
    
    override var numberOfColumn: Int {
        return 2
    }
    
    override var spacing: Double {
        return 13
    }
    
    override var heightForItem: Double {
       return 240
    }
    
    // MARK: - Properties
	var presenter: SimilarPresenterInterface!
    var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.popChildViewController(nil, true)
        }
        if let peopleDetail = peopleDetail {
            navigation.lbTitle.text = "\(peopleDetail.name)'s Films"
        } else {
            navigation.lbTitle.text = "Similar"
        }
        self.headerRefresh = {
            self.presenter.didRefresh()
        }
        self.footerRefresh = {
            self.presenter.didLoadMore(self.page)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! CinemaPopularCollectionViewCell
        let item = movies[indexPath.row]
        cell.configCell(item)
        cell.didTapAction = { [weak self] _ in
            guard let `self` = self else { return }
            self.presenter.didTapMovie(item)
        }
        return cell
    }
}

// MARK: - SimilarViewInterface
extension SimilarViewController: SimilarViewInterface {
    func getMovie(_ response: MovieResponse) {
        movies = response.results
        delay(0.5, closure: {
            self.collectionView.headRefreshControl.endRefreshing()
            self.collectionView.footRefreshControl.endRefreshing()
        })
    }
    
    var info: (id: Int, isTVShow: Bool) {
        if let payload = payload as? (Int, Bool) {
            return payload
        }
        return (0, false)
    }
    
    var peopleDetail: PeopleDetail? {
        if let payload = payload as? PeopleDetail {
            return payload
        }
        return nil
    }
}
