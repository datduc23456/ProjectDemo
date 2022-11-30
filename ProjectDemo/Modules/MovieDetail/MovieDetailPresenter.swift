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
    private var movieDetailObject: MovieDetailObject?
    private var movieDetail: MovieDetail?
    private var myReviewObject: ReviewsResultObject?
    
    init(view: MovieDetailViewInterface,
         interactor: MovieDetailInteractorInterface,
         wireframe: MovieDetailWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func didTapAddnote() {
        if let myReviewObject = myReviewObject {
            wireframe.showAddNoteScreen(myReviewObject)
        } else if let movieDetail = movieDetail {
            wireframe.showAddNoteScreen(movieDetail)
        }
    }
    
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
    
    func didTapMovie(_ movie: Movie) {
        interactor.getMovieDetail(movie.id)
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
        interactor.fetchMyReview(view!.id.0)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputInterface {
    func fetchMyReview(_ review: ReviewsResultObject) {
        self.myReviewObject = review
        view?.fetchMyReview(review)
    }
    
    func deleteMovieDetailObject(_ movie: MovieDetail) {
        view?.didDeleteMovieObject()
    }
    
    func insertMovieDetailObject(_ movie: MovieDetail) {
        view?.didInsertMovieObject()
    }
    
    func fetchRealmMovieDetailObjectWithId(_ object: MovieDetailObject) {
        self.movieDetailObject = object
        view?.fetchRealmMovieDetailObjectWithId(object)
    }
    
    func getTVShowDetail(_ response: MovieDetail) {
        self.movieDetail = response
        view?.getTVShowDetail(response)
        interactor.fetchRealmMovieDetailObjectWithId(response.id, completion: {_ in})
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        self.movieDetail = response
        view?.getMovieDetail(response)
        interactor.fetchRealmMovieDetailObjectWithId(response.id, completion: {_ in})
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        view?.handleError(error)
        wireframe.handleError(error, completion)
    }
}
