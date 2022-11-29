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
}

protocol ActionPresenterInterface: PresenterInterface {
    func didTapToMovie(_ movie: Movie)
    func didRefresh()
    func didLoadMore(_ page: Int)
}

protocol ActionInteractorInterface: InteractorInterface {
    func getMoviePopular(_ page: Int)
    func getTopRate(_ page: Int)
    func getMoviePopular(genreId: Int)
    func getTVShowPopular(_ page: Int)
    func getTVShowTopRate(_ page: Int)
}

protocol ActionInteractorOutputInterface: InteractorOutputInterface {
    func getMoviePopular(_ response: MovieResponse)
    func getTopRate(_ response: MovieResponse)
    func getTVShowPopular(_ response: MovieResponse)
    func getTVShowTopRate(_ response: MovieResponse)
}

protocol ActionWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int, isTVShow: Bool)
}
