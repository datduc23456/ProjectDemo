//
//  SimilarPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SimilarPresenter {
    
    private weak var view: SimilarViewInterface?
    private var interactor: SimilarInteractorInterface
    private var wireframe: SimilarWireframeInterface

    init(view: SimilarViewInterface,
         interactor: SimilarInteractorInterface,
         wireframe: SimilarWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension SimilarPresenter: SimilarPresenterInterface {
    func viewDidLoad() {
        let id = view!.info.id
        let isTVShow = view!.info.isTVShow
        if id == 0 {
            if let peopleId = view!.peopleDetail?.id {
                interactor.getSimilarMovieWithPeople(peopleId, 1)
            }
        } else {
            if isTVShow {
                interactor.getSimlarTVShow(id, 1)
            } else {
                interactor.getSimlarMovie(id, 1)
            }
        }
    }
    
    func didRefresh() {
        let id = view!.info.id
        let isTVShow = view!.info.isTVShow
        if id == 0 {
            if let peopleId = view!.peopleDetail?.id {
                interactor.getSimilarMovieWithPeople(peopleId, 1)
            }
        } else {
            if isTVShow {
                interactor.getSimlarTVShow(id, 1)
            } else {
                interactor.getSimlarMovie(id, 1)
            }
        }
    }
    
    func didLoadMore(_ page: Int) {
        let id = view!.info.id
        let isTVShow = view!.info.isTVShow
        if id == 0 {
            if let peopleId = view!.peopleDetail?.id {
                interactor.getSimilarMovieWithPeople(peopleId, page)
            }
        } else {
            if isTVShow {
                interactor.getSimlarTVShow(id, page)
            } else {
                interactor.getSimlarMovie(id, page)
            }
        }
    }
    
    func didTapMovie(_ movie: Movie) {
        wireframe.showMovieDetailScreen(movie.id, movie.isTVShow())
    }
}

extension SimilarPresenter: SimilarInteractorOutputInterface {
    func getMovie(_ response: MovieResponse) {
        view?.getMovie(response)
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
