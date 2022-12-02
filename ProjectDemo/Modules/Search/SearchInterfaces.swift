//
//  SearchInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol SearchViewInterface: ViewInterface {
    var searchType: SearchType { get }
    func searchMoviePopular(_ response: [Movie])
    func searchTVShowPopular(_ response: [Movie])
    func searchPerson(_ response: [Cast])
    func getMovieDetail(_ response: MovieDetail)
    func getTVShowDetail(_ response: MovieDetail)
    func fetchSearchKey(_ keys: [SearchKeyObject])
}

protocol SearchPresenterInterface: PresenterInterface {
    func searchMoviePopular(_ query: String)
    func searchTVShowPopular(_ query: String)
    func searchPerson(_ query: String)
    func searchGenre(_ genre: Genre)
    func fetchSearchKey()
    func didTapToMovie(_ movie: Movie)
    func didTapToTVshow(_ movie: Movie)
    func didTapToCast(_ cast: Cast)
    func didSearch(_ key: String)
}

protocol SearchInteractorInterface: InteractorInterface {
    func getMovieDetail(_ id: Int)
    func getTVShowDetail(_ id: Int)
    func searchMoviePopular(_ query: String)
    func searchTVShowPopular(_ query: String)
    func searchPerson(_ query: String)
    func fetchSearchKey()
    func insertQuery(_ query: String)
    func searchMoviePopularWithGenre(genreId: Int, _ page: Int)
    func searchTVShowPopularWithGenre(genreId: Int, _ page: Int)
}

protocol SearchInteractorOutputInterface: InteractorOutputInterface {
    func getMovieDetail(_ response: MovieDetail)
    func getTVShowDetail(_ response: MovieDetail)
    func searchMoviePopular(_ response: [Movie])
    func searchTVShowPopular(_ response: [Movie])
    func searchPerson(_ response: [Cast])
    func fetchSearchKey(_ keys: [SearchKeyObject])
    func searchMoviePopularWithGenre(_ response: [Movie])
    func searchTVShowPopularWithGenre(_ response: [Movie])
}

protocol SearchWireframeInterface: WireframeInterface {
    func showAddNoteScreen(_ response: MovieDetail)
    func showWatchedListScreen(_ response: MovieDetail)
    func showMovieDetailScreen(_ id: Int)
    func showTVShowDetailScreen(_ id: Int)
}
