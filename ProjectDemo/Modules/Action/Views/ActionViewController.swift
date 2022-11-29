//
//  ActionViewController.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

enum ActionViewType {
    case moviepopular
    case topRated
    case tvshowpopular
    case tvshowtoprated
    case genre(Genre)
}

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
    
    var movie: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.navigationController?.popViewController(animated: true)
        }
        
        switch actionViewType {
        case .moviepopular:
            navigation.lbTitle.text = "Popular Movie"
        case .topRated:
            navigation.lbTitle.text = "Top Rated"
        case .tvshowpopular:
            navigation.lbTitle.text = "TV Show Popular"
        case .tvshowtoprated:
            navigation.lbTitle.text = "Trending"
        case .genre(let genre):
            navigation.lbTitle.text = genre.name
        }
        self.headerRefresh = {
            self.movie.removeAll()
            self.presenter.didRefresh()
        }
        self.footerRefresh = {
            self.presenter.didLoadMore(self.page)
        }
    }
    
	var presenter: ActionPresenterInterface!
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! CinemaPopularCollectionViewCell
        let movie = movie[indexPath.row]
        cell.viewFavorite.isHidden = false
        cell.configCell(movie)
        cell.didTapAction = { [weak self] any in
            guard let `self` = self, let movie = any as? Movie else { return }
            self.presenter.didTapToMovie(movie)
        }
        return cell
    }
}

// MARK: - ActionViewInterface
extension ActionViewController: ActionViewInterface {
    var actionViewType: ActionViewType {
        if let type = payload as? ActionViewType {
            return type
        }
        return .moviepopular
    }
    
    func hideLoading() {
        self.collectionView.headRefreshControl.endRefreshing()
        self.collectionView.footRefreshControl.endRefreshing()
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        self.movie += response.results
        self.collectionView.reloadData()
    }
    
    func getTVShowTopRate(_ response: MovieResponse) {
        self.movie += response.results
        self.collectionView.reloadData()
    }
    
    func getMoviePopular(_ response: MovieResponse) {
        self.movie += response.results
        self.collectionView.reloadData()
    }
    
    func getTopRate(_ response: MovieResponse) {
        self.movie += response.results
        self.collectionView.reloadData()
    }
}
