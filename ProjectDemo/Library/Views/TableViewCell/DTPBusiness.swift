//
//  DTPBusiness.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 20/11/2022.
//

import Foundation

class DTPBusiness {
    static let shared = DTPBusiness()
    var listGenres: [Genre] = []
    var genreSelectedId: Int = 0
    var realmUtils: RealmUtils = AppDelegate.shared.realmUtils!
    
    func mapToGenreName(_ listGenreIds: [Int]) -> String {
        var listGenresFilter: [Genre] = []
        
        for id in listGenreIds {
            if let genre = listGenres.first(where: {$0.id == id}) {
                listGenresFilter.append(genre)
            }
        }
        
        return listGenresFilter.map { $0.name }.reduce("") { (result, next) -> String in
            if result.isEmpty {
                return next
            }
            return "\(result), \(next)"
        }
    }
    
    func roundRating(_ rating: Double) -> String {
        if rating < 1000 {
            return "\(Int(rating))"
        } else {
            let rounded = rating.rounded(toPlaces: 3)
            return "\(Int(rounded))k"
        }
    }
    
    func fetchMyReviewWithId(_ movieId: Int, completion: ((ReviewsResultObject?) -> Void)) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: movieId))
        let query = realmUtils.dataQueryByPredicate(type: ReviewsResultObject.self, predicate: predicate)
        if !query.isEmpty {
            completion(query[0])
        } else {
            completion(nil)
        }
    }
    
    func fetchRealmMovieDetailObjectWithId(_ id: Int, completion: ((MovieDetailObject?) -> Void)) {
        let predicate = NSPredicate(format: "_id == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
        if !query.isEmpty {
            completion(query[0])
        } else {
            completion(nil)
        }
    }
    
    func fetchMovieDetailObjectWatchedList(completion: (([MovieDetailObject]) -> Void)) {
        let movies = Array(realmUtils.dataQuery(type: MovieDetailObject.self))
        completion(movies)
    }
    
    func fetchMovieDetailObjectWatchedListWithId(_ id: Int, completion: ((MovieDetailObject?) -> Void)) {
        fetchRealmMovieDetailObjectWithId(id, completion: { movie in
            if let movie = movie, movie.isWatchedList {
                completion(movie)
            } else {
                completion(nil)
            }
        })
    }
    
    func deleteMovieDetailObject(_ movie: MovieDetail, completion: ((MovieDetailObject?) -> Void)) {
        self.fetchRealmMovieDetailObjectWithId(movie.id, completion: { object in
            if let object = object {
                self.realmUtils.deleteObject(object: object)
            }
            completion(object)
        })
    }
    
    func insertMovieDetailObject(_ movie: MovieDetail) {
        self.realmUtils.insertOrUpdate(movie.toMovieObject())
    }
    
    func insertReviewsResultObject(_ review: ReviewsResultObject) {
        self.realmUtils.insertOrUpdate(review)
    }
}
