//
//  ActionInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol ActionViewInterface: ViewInterface {
    var actionViewType: ActionViewType { get }
    func getMoviePopular(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
    func getTVShowPopular(_ response: MovieResponse)
    func getTVShowTopRate(_ response: MovieResponse)
    func getTvShowTrending(_ response: MovieResponse)
    func getMovieTrending(_ response: MovieResponse)
}

protocol ActionPresenterInterface: PresenterInterface {
    func didTapToMovie(_ movie: Movie)
    func didRefresh()
    func didLoadMore(_ page: Int)
    func didTapFavorite(_ movie: Movie, isFavorite: Bool)
}

protocol ActionInteractorInterface: InteractorInterface {
    func getMoviePopular(_ page: Int)
    func getTopRate(_ page: Int)
    func getMoviePopular(genreId: Int, _ page: Int)
    func getTVShowPopular(_ page: Int)
    func getTVShowTopRate(_ page: Int)
    func getTvShowTrending(_ page: Int)
    func getMovieTrending(_ page: Int)
    func getNewMovie(_ page: Int)
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject)->Void))
    func deleteMovieDetailObject(_ movie: Movie)
    func insertMovieDetailObject(_ movie: Movie)
}

protocol ActionInteractorOutputInterface: InteractorOutputInterface {
    func getMoviePopular(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
    func getTVShowPopular(_ response: MovieResponse)
    func getTVShowTopRate(_ response: MovieResponse)
    func getTvShowTrending(_ response: MovieResponse)
    func getMovieTrending(_ response: MovieResponse)
    func deleteMovieDetailObject(_ movie: Movie)
    func insertMovieDetailObject(_ movie: Movie)
}

protocol ActionWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int, isTVShow: Bool)
}
