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
    case newmovie
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
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 400
        }
       return 260
    }
    var bottomSheet: BaseViewBottomSheetViewController!
    var movies: [Movie] = []
    var movieFilterType: MovieFilterType = .all {
        didSet {
            movies = sortByMovieFilterType(movies)
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.filter)
        navigation.btnBack.addTapGestureRecognizer {
            self.didPopViewController(nil, true)
        }
        navigation.imgFilter.addTapGestureRecognizer {
            self.bottomSheet = BaseViewBottomSheetViewController()
            self.bottomSheet.payload = 0
            self.bottomSheet.bottomDataSource = MovieFilterType.allCases.compactMap({ return .label(title: $0.title, isChoose: $0 == self.movieFilterType)})
            self.present(self.bottomSheet, animated: true, completion: {
                self.bottomSheet.stackContent.delegate = self
            })
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
        case .newmovie:
            navigation.lbTitle.text = "New movie"
        case .genre(let genre):
            navigation.lbTitle.text = genre.name
        }
        self.headerRefresh = {
            self.movies.removeAll()
            self.presenter.didRefresh()
        }
        self.footerRefresh = {
            self.presenter.didLoadMore(self.page)
        }
    }
    
	var presenter: ActionPresenterInterface!
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! CinemaPopularCollectionViewCell
        let movie = movies[indexPath.row]
        cell.imageHeight.constant = 169
        cell.viewFavorite.isHidden = false
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: movie.id))
        let query = self.realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
        if !query.isEmpty {
            cell.icFavorite.image = UIImage(named: "ic_heart_color")
        } else {
            cell.icFavorite.image = UIImage(named: "ic_heart")
        }
        let isNeedFixedLayoutForIPad = UIDevice.current.userInterfaceIdiom == .pad
        cell.configCell(movie, isNeedFixedLayoutForIPad: isNeedFixedLayoutForIPad)
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
        self.scrollView.headRefreshControl.endRefreshing()
        self.scrollView.footRefreshControl.endRefreshing()
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        appendMovie(response)
    }
    
    func getTVShowTopRate(_ response: MovieResponse) {
        appendMovie(response)
    }
    
    func getMoviePopular(_ response: MovieResponse) {
        appendMovie(response)
    }
    
    func getTopRate(_ response: MovieResponse) {
        appendMovie(response)
    }
    
    func getTvShowTrending(_ response: MovieResponse) {
        appendMovie(response)
    }
    
    func getMovieTrending(_ response: MovieResponse) {
        appendMovie(response)
    }
    
    func appendMovie(_ response: MovieResponse) {
        self.movies = sortByMovieFilterType(movies) + sortByMovieFilterType(response.results)
        self.collectionView.reloadData()
    }
    
    func sortByMovieFilterType(_ movies: [Movie]) -> [Movie] {
        var results = movies
        switch movieFilterType {
        case .all:
            break
        case .nameAZ:
            results.sort(by: {$0.originalTitle < $1.originalTitle})
        case .nameZA:
            results.sort(by: {$0.originalTitle > $1.originalTitle})
        case .myRating:
            results.sort(by: {$0.voteAverage > $1.voteAverage})
//            let listMovieFavorites = Array(self.realmUtils.dataQuery(type: MovieDetailObject.self))
//            results.sort(by: { lhs, rhs in
//                let leftRating = listMovieFavorites.first(where: {$0._id == lhs.id}) != nil ? listMovieFavorites.first(where: {$0._id == lhs.id})!._id : 0
//                let rightRating = listMovieFavorites.first(where: {$0._id == rhs.id}) != nil ? listMovieFavorites.first(where: {$0._id == rhs.id})!._id : 0
//                return leftRating > rightRating
//            })
        }
        return results
    }
}

extension ActionViewController: BoottomSheetStackViewDelegate {
    func didSelect(_ bottomSheetStackView: BottomSheetStackView, selectedIndex index: Int) {
        if let _ = bottomSheet.payload as? Int {
            switch index {
            case 1:
                movieFilterType = .all
            case 2:
                movieFilterType = .nameAZ
            case 3:
                movieFilterType = .nameZA
            default:
                movieFilterType = .myRating
            }
            self.bottomSheet.shouldDismissSheet()
        }
    }
}
