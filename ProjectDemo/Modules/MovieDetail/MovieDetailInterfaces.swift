//
//  MovieDetailInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol MovieDetailViewInterface: ViewInterface {
    var id: (Int, Bool) { get }
    func getMovieDetail(_ response: MovieDetail)
    func getTVShowDetail(_ response: MovieDetail)
    func fetchMyReview(_ review: ReviewsResultObject)
    func fetchRealmMovieDetailObjectWithId(_ object: MovieDetailObject)
    func fetchMovieDetailObjectWatchedListWithId(_ object: WatchedListObject?)
    func didDeleteMovieObject()
    func didInsertMovieObject()
}

protocol MovieDetailPresenterInterface: PresenterInterface {
    func didTapPlayVideo(_ video: Video)
    func didTapFavorite(_ movie: MovieDetail, isFavorite: Bool)
    func didTapPeople(_ id: Int)
    func didTapMovie(_ movie: Movie)
    func didTapAddnote()
    func didTapUserNote()
}

protocol MovieDetailInteractorInterface: InteractorInterface {
    func getMovieDetail(_ id: Int)
    func getTVShowDetail(_ id: Int)
    func fetchMyReview(_ id: Int)
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject)->Void))
    func deleteMovieDetailObject(_ movie: MovieDetail)
    func insertMovieDetailObject(_ movie: MovieDetail)
    func insertMovieDetailObjectWatchedList(_ movie: MovieDetail)
    func fetchWatchedListObjectWithId(_ id: Int)
}

protocol MovieDetailInteractorOutputInterface: InteractorOutputInterface {
    func getMovieDetail(_ response: MovieDetail)
    func getTVShowDetail(_ response: MovieDetail)
    func fetchMyReview(_ review: ReviewsResultObject)
    func fetchRealmMovieDetailObjectWithId(_ object: MovieDetailObject)
    func fetchMovieDetailObjectWatchedListWithId(_ object: WatchedListObject?)
    func deleteMovieDetailObject(_ movie: MovieDetail)
    func insertMovieDetailObject(_ movie: MovieDetail)
}

protocol MovieDetailWireframeInterface: WireframeInterface {
    func showPeopleDetail(_ id: Int)
    func showAddNoteScreen(_ payload: Any)
    func showUserNoteScreen(_ movieDetail: MovieDetail)
}
