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
}

protocol TVShowPresenterInterface: PresenterInterface {
    func didTapToMovie(_ movie: Movie)
}

protocol TVShowInteractorInterface: InteractorInterface {
    func getTVShowPopular()
    func getTVShowLastest()
    func getTopRate()
}

protocol TVShowInteractorOutputInterface: InteractorOutputInterface {
    func getTVShowPopular(_ response: MovieResponse)
    func getTVShowLastest(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
}

protocol TVShowWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int)
}
