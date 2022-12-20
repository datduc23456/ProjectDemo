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
    private var myReviewObject: [ReviewsResultObject]?
    private var watchedListObject: WatchedListObject?
    
    init(view: MovieDetailViewInterface,
         interactor: MovieDetailInteractorInterface,
         wireframe: MovieDetailWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func didTapSimilar() {
        wireframe.showSimilarScreen((view!.id.0, view!.id.1))
    }
    
    func didTapVideos() {
        if let videos = movieDetail?.videos.video {
            wireframe.showVideosScreen(videos)
        }
    }
    
    func didTapImage() {
//        listVideos.map({CommonUtil.getThumbnailYoutubeUrl($0.key)})
        if let urls = movieDetail?.videos.video.map({CommonUtil.getThumbnailYoutubeUrl($0.key)}) {
            wireframe.showImagesScreen(urls)
        }
    }
    
    func didTapSeason() {
        if let season = movieDetail?.seasons {
            wireframe.showSeasonScreen(season)
        }
    }
    
    func didTapUserNote() {
        if let movieDetail = movieDetail {
            wireframe.showUserNoteScreen(movieDetail)
        }
    }
    
    func didTapAddnote() {
//        if let myReviewObject = myReviewObject {
//            wireframe.showAddNoteScreen(myReviewObject)
//        } else
        if let movieDetail = movieDetail {
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
        let payload = view!.id
        let isTVShow = payload.1
        if !isTVShow {
            interactor.getMovieDetail(movie.id)
        } else {
            interactor.getTVShowDetail(movie.id)
        }
        interactor.fetchMyReview(movie.id)
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
    func fetchMovieDetailObjectWatchedListWithId(_ object: WatchedListObject?) {
        watchedListObject = object
        view?.fetchMovieDetailObjectWatchedListWithId(object)
    }
    
    func fetchMyReview(_ reviews: [ReviewsResultObject]) {
        self.myReviewObject = reviews
        view?.fetchMyReview(reviews)
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
        interactor.fetchWatchedListObjectWithId(response.id)
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        self.movieDetail = response
        view?.getMovieDetail(response)
        interactor.fetchRealmMovieDetailObjectWithId(response.id, completion: {_ in})
        interactor.fetchWatchedListObjectWithId(response.id)
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        view?.handleError(error)
        wireframe.handleError(error, completion)
    }
}
