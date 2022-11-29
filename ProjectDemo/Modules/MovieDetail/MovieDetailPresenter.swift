//
//  MovieDetailPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class MovieDetailPresenter {

    private weak var view: MovieDetailViewInterface?
    private var interactor: MovieDetailInteractorInterface
    private var wireframe: MovieDetailWireframeInterface

    init(view: MovieDetailViewInterface,
         interactor: MovieDetailInteractorInterface,
         wireframe: MovieDetailWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func didTapPeople(_ id: Int) {
        wireframe.showPeopleDetail(id)
    }
    
    func didTapFavorite(_ movie: MovieDetail, isFavorite: Bool) {
        if isFavorite {
            interactor.deleteMovieDetailObject(movie)
        } else {
            interactor.insertMovieDetailObject(movie)
        }
    }
    
    func didTapPlayVideo(_ video: Video) {
        wireframe.showPlayVideo(video.key, false)
    }
    
    func viewWillAppear(_ animated: Bool) {
        
    }
    
    func viewDidLoad() {
        let payload = view!.id
        let isTVShow = payload.1
        if !isTVShow {
            interactor.getMovieDetail(view!.id.0)
        } else {
            interactor.getTVShowDetail(view!.id.0)
        }
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputInterface {
    func deleteMovieDetailObject(_ movie: MovieDetail) {
        view?.didDeleteMovieObject()
    }
    
    func insertMovieDetailObject(_ movie: MovieDetail) {
        view?.didInsertMovieObject()
    }
    
    func fetchRealmMovieDetailObjectWithId(_ object: MovieDetailObject) {
        view?.fetchRealmMovieDetailObjectWithId(object)
    }
    
    func getTVShowDetail(_ response: MovieDetail) {
        view?.getTVShowDetail(response)
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        view?.getMovieDetail(response)
        interactor.fetchRealmMovieDetailObjectWithId(response.id, completion: {_ in})
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        view?.handleError(error)
        wireframe.handleError(error, completion)
    }
}
