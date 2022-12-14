//
//  TVShowInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol TVShowViewInterface: ViewInterface {
    func getTVShowPopular(_ response: MovieResponse)
    func getGenresList(_ response: GenreResponse)
    func getTVShowLastest(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
    func getTrendingTv(_ response: MovieResponse)
    func fetchRealmMovieDetailObjectWithId(_ object: [MovieDetailObject])
    func didDeleteMovieObject()
    func didInsertMovieObject()
    func getTVShowDetail(_ response: MovieDetail)
}

protocol TVShowPresenterInterface: PresenterInterface {
    func didTapToMovie(_ movie: Movie)
    func didChangeMovieHeader(_ movie: Movie)
    func didTapHeaderView(_ section: TVShowTableViewDataSource)
    func didTapFavorite(_ movie: Movie, isFavorite: Bool)
    func didTapSearch()
    func didTapSetting()
    func didTapPlayVideo(_ video: Video)
}

protocol TVShowInteractorInterface: InteractorInterface {
    func getTVShowPopular()
    func getTVShowLastest()
    func getTopRate()
    func getTrendingTv()
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject)->Void))
    func deleteMovieDetailObject(_ movie: Movie)
    func insertMovieDetailObject(_ movie: Movie)
    func getTVShowDetail(_ id: Int)
}

protocol TVShowInteractorOutputInterface: InteractorOutputInterface {
    func getTVShowPopular(_ response: MovieResponse)
    func getTVShowLastest(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
    func getTrendingTv(_ response: MovieResponse)
    func deleteMovieDetailObject(_ movie: Movie)
    func insertMovieDetailObject(_ movie: Movie)
    func fetchRealmMovieDetailObjectWithId(_ object: [MovieDetailObject])
    func getTVShowDetail(_ response: MovieDetail)
}

protocol TVShowWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int)
    func showActionScreen(_ type: ActionViewType)
    func showSearchScreen()
    func showSettingScreen()
}
