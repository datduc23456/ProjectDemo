//
//  TVShowPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class TVShowPresenter {

    private weak var view: TVShowViewInterface?
    private var interactor: TVShowInteractorInterface
    private var wireframe: TVShowWireframeInterface

    init(view: TVShowViewInterface,
         interactor: TVShowInteractorInterface,
         wireframe: TVShowWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension TVShowPresenter: TVShowPresenterInterface {
    func didTapPlayVideo(_ video: Video) {
        wireframe.showPlayVideo(video.key, false)
    }
    
    func didChangeMovieHeader(_ movie: Movie) {
        interactor.getTVShowDetail(movie.id)
        interactor.fetchRealmMovieDetailObjectWithId(movie.id, completion: {_ in})
    }
    
    func didTapFavorite(_ movie: Movie, isFavorite: Bool) {
        if isFavorite {
            interactor.deleteMovieDetailObject(movie)
        } else {
            interactor.insertMovieDetailObject(movie)
        }
    }
    
    func viewDidLoad() {
        interactor.getTVShowPopular()
        interactor.getTVShowLastest()
        interactor.getTopRate()
        interactor.getTrendingTv()
    }
    
    func didTapSearch() {
        wireframe.showSearchScreen()
    }
    
    func didTapToMovie(_ movie: Movie) {
        wireframe.showMovieDetailScreen(movie.id)
    }
    
    func didTapHeaderView(_ section: TVShowTableViewDataSource) {
        switch section {
        case .popular:
            wireframe.showActionScreen(.tvshowpopular)
        case .trending:
            wireframe.showActionScreen(.tvshowtrending)
        default:
            return
        }
    }
    
    func didTapSetting() {
        wireframe.showSettingScreen()
    }
}

extension TVShowPresenter: TVShowInteractorOutputInterface {
    func getTVShowDetail(_ response: MovieDetail) {
        view?.getTVShowDetail(response)
    }
    
    func getTrendingTv(_ response: MovieResponse) {
        view?.getTrendingTv(response)
    }
    
    func fetchRealmMovieDetailObjectWithId(_ object: [MovieDetailObject]) {
        view?.fetchRealmMovieDetailObjectWithId(object)
    }
    
    func deleteMovieDetailObject(_ movie: Movie) {
        view?.didDeleteMovieObject()
    }
    
    func insertMovieDetailObject(_ movie: Movie) {
        view?.didInsertMovieObject()
    }
    
    func getTopRate(_ response: MovieResponse) {
        view?.getTopRate(response)
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        view?.getTVShowPopular(response)
    }
    
    func getTVShowLastest(_ response: MovieResponse) {
        view?.getTVShowLastest(response)
    }

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
