//
//  HomeInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol HomeViewInterface: ViewInterface {
    func getMoviePopular(_ response: MovieResponse)
    func getGenresList(_ response: GenreResponse)
    func getTopRate(_ response: MovieResponse)
    func getTrending(_ response: MovieResponse)
}

protocol HomePresenterInterface: PresenterInterface {
    func didTapToMovie(_ movie: Movie)
    func didTapSearch()
    func didTapSetting()
    func didTapToGenre(_ genre: Genre)
    func didTapHeaderView(_ section: HomeTableViewDataSource)
}

protocol HomeInteractorInterface: InteractorInterface {
    func getMoviePopular()
    func getGenresList()
    func getTopRate()
    func getTrendingMovie()
    func getMoviePopular(_ genreId: Int)
}

protocol HomeInteractorOutputInterface: InteractorOutputInterface {
    func getMoviePopular(_ response: MovieResponse)
    func getGenresList(_ response: GenreResponse)
    func getTopRate(_ response: MovieResponse)
    func getTrending(_ response: MovieResponse)
}

protocol HomeWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int)
    func showSearchScreen()
    func showActionScreen(_ type: ActionViewType)
    func showGenersScreen()
    func showSettingScreen()
}
