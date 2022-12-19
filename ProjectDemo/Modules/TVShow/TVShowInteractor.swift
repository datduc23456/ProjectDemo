//
//  TVShowInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import Foundation

final class TVShowInteractor {
    var realmUtils: RealmUtils! {
        get {
            AppDelegate.shared.realmUtils!
        }
    }
    weak var output: TVShowInteractorOutputInterface?
}

extension TVShowInteractor: TVShowInteractorInterface {
    func getTVShowDetail(_ id: Int) {
        ServiceCore.shared.request(MovieDetail.self, targetType: CoreTargetType.TVshowDetail(id), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowDetail(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTrendingTv() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.trendingTvShow(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTrendingTv(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    
    func getTopRate() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowTopRate(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTopRate(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowPopular() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowPopular(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowPopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowLastest() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowLastest(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowLastest(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject)->Void)) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
        if !query.isEmpty {
            completion(query[0])
        }
        self.output?.fetchRealmMovieDetailObjectWithId(Array(query))
    }
    
    func deleteMovieDetailObject(_ movie: Movie) {
        self.fetchRealmMovieDetailObjectWithId(movie.id, completion: { object in
            self.realmUtils.deleteObject(object: object)
            self.output?.deleteMovieDetailObject(movie)
        })
    }
    
    func insertMovieDetailObject(_ movie: Movie) {
        self.realmUtils.insertOrUpdate(movie.toMovieObject())
        self.output?.insertMovieDetailObject(movie)
    }
}
