//
//  SearchInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol SearchViewInterface: ViewInterface {
    func searchMoviePopular(_ response: [Movie])
    func searchTVShowPopular(_ response: [Movie])
    func searchPerson(_ response: [Cast])
}

protocol SearchPresenterInterface: PresenterInterface {
    func searchMoviePopular(_ query: String)
    func searchTVShowPopular(_ query: String)
    func searchPerson(_ query: String)
    func didTapToMovie(_ movie: Movie)
    func didTapToTVshow(_ movie: Movie)
    func didTapToCast(_ cast: Cast)
}

protocol SearchInteractorInterface: InteractorInterface {
    func searchMoviePopular(_ query: String)
    func searchTVShowPopular(_ query: String)
    func searchPerson(_ query: String)
}

protocol SearchInteractorOutputInterface: InteractorOutputInterface {
    func searchMoviePopular(_ response: [Movie])
    func searchTVShowPopular(_ response: [Movie])
    func searchPerson(_ response: [Cast])
}

protocol SearchWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int)
    func showTVShowDetailScreen(_ id: Int)
}
