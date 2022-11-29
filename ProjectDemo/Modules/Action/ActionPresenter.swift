//
//  ActionPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class ActionPresenter {

    private weak var view: ActionViewInterface?
    private var interactor: ActionInteractorInterface
    private var wireframe: ActionWireframeInterface

    init(view: ActionViewInterface,
         interactor: ActionInteractorInterface,
         wireframe: ActionWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension ActionPresenter: ActionPresenterInterface {
    func viewDidLoad() {
        switch view!.actionViewType {
        case .moviepopular:
            interactor.getMoviePopular(1)
        case .topRated:
            interactor.getTopRate(1)
        case .tvshowpopular:
            interactor.getTVShowPopular(1)
        case .tvshowtoprated:
            interactor.getTVShowTopRate(1)
        case .genre(let genre):
            interactor.getMoviePopular(genreId: genre.id, 1)
        default:
            return
        }
    }
    
    func didTapToMovie(_ movie: Movie) {
        switch view!.actionViewType {
        case .moviepopular, .topRated, .genre:
            wireframe.showMovieDetailScreen(movie.id, isTVShow: false)
        case .tvshowpopular, .tvshowtoprated:
            wireframe.showMovieDetailScreen(movie.id, isTVShow: true)
        default:
            return
        }
    }
    
    func didRefresh() {
        switch view!.actionViewType {
        case .moviepopular:
            interactor.getMoviePopular(1)
        case .topRated:
            interactor.getTopRate(1)
        case .tvshowpopular:
            interactor.getTVShowPopular(1)
        case .tvshowtoprated:
            interactor.getTVShowTopRate(1)
        case .genre(let genre):
            interactor.getMoviePopular(genreId: genre.id, 1)
        default:
            return
        }
    }
    
    func didLoadMore(_ page: Int) {
        switch view!.actionViewType {
        case .moviepopular:
            interactor.getMoviePopular(page)
        case .topRated:
            interactor.getTopRate(page)
        case .tvshowpopular:
            interactor.getTVShowPopular(page)
        case .tvshowtoprated:
            interactor.getTVShowTopRate(page)
        case .genre(let genre):
            interactor.getMoviePopular(genreId: genre.id, page)
        default:
            return
        }
    }
    
    func didTapFavorite(_ movie: Movie, isFavorite: Bool) {
        if isFavorite {
            interactor.insertMovieDetailObject(movie)
        } else {
            interactor.deleteMovieDetailObject(movie)
        }
    }
}

extension ActionPresenter: ActionInteractorOutputInterface {
    func deleteMovieDetailObject(_ movie: Movie) {
        
    }
    
    func insertMovieDetailObject(_ movie: Movie) {
        
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        view?.getTVShowPopular(response)
        view?.hideLoading()
    }
    
    func getTVShowTopRate(_ response: MovieResponse) {
        view?.getTVShowTopRate(response)
        view?.hideLoading()
    }
    
    func getMoviePopular(_ response: MovieResponse) {
        view?.getMoviePopular(response)
        view?.hideLoading()
    }
    
    func getTopRate(_ response: MovieResponse) {
        view?.getTopRate(response)
        view?.hideLoading()
    }

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
