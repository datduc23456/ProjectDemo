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
    func searchGenre(_ genre: Genre) {
        interactor.searchMoviePopularWithGenre(genreId: genre.id, 1)
        interactor.searchTVShowPopularWithGenre(genreId: genre.id, 1)
    }
    
    func viewDidLoad() {
        interactor.fetchSearchKey()
    }
    
    func fetchSearchKey() {
        interactor.fetchSearchKey()
    }
    
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
        switch view!.searchType {
        case .detail:
            wireframe.showMovieDetailScreen(movie.id)
        default:
            interactor.getMovieDetail(movie.id)
        }
    }
    
    func didTapToTVshow(_ movie: Movie) {
        switch view!.searchType {
        case .detail:
            wireframe.showTVShowDetailScreen(movie.id)
        default:
            interactor.getTVShowDetail(movie.id)
        }
    }
    
    func didTapToCast(_ cast: Cast) {
        
    }
}

extension SearchPresenter: SearchInteractorOutputInterface {
    func searchMoviePopularWithGenre(_ response: [Movie]) {
        view?.searchMoviePopular(response)
    }
    
    func searchTVShowPopularWithGenre(_ response: [Movie]) {
        view?.searchTVShowPopular(response)
    }
    
    func didSearch(_ key: String) {
        interactor.insertQuery(key)
    }
    
    func fetchSearchKey(_ keys: [SearchKeyObject]) {
        view?.fetchSearchKey(keys)
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        view?.getMovieDetail(response)
        switch view!.searchType {
        case .addnote:
            wireframe.popScreen(result: response)
        case .watchedlist:
            wireframe.showWatchedListScreen(response)
        default:
            return
        }
    }
    
    func getTVShowDetail(_ response: MovieDetail) {
        view?.getTVShowDetail(response)
        switch view!.searchType {
        case .addnote:
            wireframe.showAddNoteScreen(response)
        case .watchedlist:
            wireframe.showWatchedListScreen(response)
        default:
            return
        }
    }
    
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
