//
//  MovieDetailInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import Foundation

final class MovieDetailInteractor {
    let realmUtils = AppDelegate.shared.realmUtils!
    weak var output: MovieDetailInteractorOutputInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
    
    func getMovieDetail(_ id: Int) {
        ServiceCore.shared.request(MovieDetail.self, targetType: CoreTargetType.detail(id), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMovieDetail(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowDetail(_ id: Int) {
        ServiceCore.shared.request(MovieDetail.self, targetType: CoreTargetType.TVshowDetail(id), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowDetail(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject)->Void)) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
        if !query.isEmpty {
            self.output?.fetchRealmMovieDetailObjectWithId(query[0])
            completion(query[0])
        }
    }
    
    func deleteMovieDetailObject(_ movie: MovieDetail) {
        self.fetchRealmMovieDetailObjectWithId(movie.id, completion: { object in
            self.realmUtils.deleteObject(object: object)
            self.output?.deleteMovieDetailObject(movie)
        })
    }
    
    func insertMovieDetailObject(_ movie: MovieDetail) {
        self.realmUtils.insertOrUpdate(movie.toMovieObject())
        self.output?.insertMovieDetailObject(movie)
    }
    
    func insertMovieDetailObjectWatchedList(_ movie: MovieDetail) {
        let object = movie.toMovieObject()
        object.isWatchedList = true
        self.realmUtils.insertOrUpdate(object)
        self.output?.insertMovieDetailObject(movie)
    }
    
    func fetchMyReview(_ id: Int) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: ReviewsResultObject.self, predicate: predicate)
        if !query.isEmpty {
            self.output?.fetchMyReview(query[0])
        }
    }
    
    func fetchWatchedListObjectWithId(_ id: Int) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: WatchedListObject.self, predicate: predicate)
        self.output?.fetchMovieDetailObjectWatchedListWithId(query[safe: 0])
    }
}
