//
//  ActionInteractor.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import Foundation

final class ActionInteractor {
    let realmUtils = AppDelegate.shared.realmUtils!
    weak var output: ActionInteractorOutputInterface?
}

extension ActionInteractor: ActionInteractorInterface {
    func didTapFavorite(_ movie: MovieDetail, isFavorite: Bool) {
        
    }
    
    
    func getMoviePopular(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.popular(page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTopRate(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.movieTopRated(page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTopRate(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getMoviePopular(genreId: Int, _ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.moviegenreid(genreId: genreId, page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowTopRate(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowTopRate(page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTopRate(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowPopular(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowPopular(page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowPopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTvShowTrending(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.trendingTvShow(page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowPopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getMovieTrending(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.trendingMovie(page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowPopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getNewMovie(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.newMovie(page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
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
