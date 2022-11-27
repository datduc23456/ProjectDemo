//
//  SearchPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SearchPresenter {

    private weak var view: SearchViewInterface?
    private var interactor: SearchInteractorInterface
    private var wireframe: SearchWireframeInterface

    init(view: SearchViewInterface,
         interactor: SearchInteractorInterface,
         wireframe: SearchWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension SearchPresenter: SearchPresenterInterface {
    func searchMoviePopular(_ query: String) {
        interactor.searchMoviePopular(query)
    }
    
    func searchTVShowPopular(_ query: String) {
        interactor.searchTVShowPopular(query)
    }
    
    func searchPerson(_ query: String) {
        interactor.searchPerson(query)
    }
    
    func didTapToMovie(_ movie: Movie) {
        wireframe.showMovieDetailScreen(movie.id)
    }
    
    func didTapToTVshow(_ movie: Movie) {
        wireframe.showTVShowDetailScreen(movie.id)
    }
    
    func didTapToCast(_ cast: Cast) {
        
    }
}

extension SearchPresenter: SearchInteractorOutputInterface {
    
    func searchMoviePopular(_ response: [Movie]) {
        view?.searchMoviePopular(response)
    }
    
    func searchTVShowPopular(_ response: [Movie]) {
        view?.searchTVShowPopular(response)
    }
    
    func searchPerson(_ response: [Cast]) {
        view?.searchPerson(response)
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
