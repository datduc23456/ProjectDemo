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
    case tvshowtrending
    case movietrending
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
        case .tvshowtrending, .movietrending:
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
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: movie.id))
        let query = self.realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
        if !query.isEmpty {
            cell.icFavorite.image = UIImage(named: "ic_heart_color")
        }
        cell.configCell(movie)
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
            if let movie = any as? Movie {
                self.presenter.didTapToMovie(movie)
            } else if let payload = any as? (Movie, Bool) {
                self.presenter.didTapFavorite(payload.0, isFavorite: payload.1)
            }
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
    
    func getTvShowTrending(_ response: MovieResponse) {
        self.movie += response.results
        self.collectionView.reloadData()
    }
    
    func getMovieTrending(_ response: MovieResponse) {
        self.movie += response.results
        self.collectionView.reloadData()
    }
}
