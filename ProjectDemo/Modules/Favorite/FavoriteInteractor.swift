//
//  FavoriteInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import Foundation

final class FavoriteInteractor {
    var realmUtils: RealmUtils! {
        get {
            AppDelegate.shared.realmUtils!
        }
    }
    weak var output: FavoriteInteractorOutputInterface?
}

extension FavoriteInteractor: FavoriteInteractorInterface {
    func getMovieFavorite(_ type: FavoriteFilterType) {
        switch type {
        case .movie:
            let predicate = NSPredicate(format: "isTVShow == %@", NSNumber(booleanLiteral: false))
            var realms = self.realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
            switch DTPBusiness.shared.movieFilterType {
            case .nameAZ:
                realms = realms.sorted(byKeyPath: "originalName", ascending: true)
            case .nameZA:
                realms = realms.sorted(byKeyPath: "originalName", ascending: false)
            case .myRating:
                realms = realms.sorted(byKeyPath: "voteAverage", ascending: false)
            default:
                break
            }
            let array = Array(realms)
            let data = Dictionary(grouping: array, by: { $0.releaseDate })
            self.output?.getMovieFavorite(data)
        case .tvshow:
            let predicate = NSPredicate(format: "isTVShow == %@", NSNumber(booleanLiteral: true))
            var realms = self.realmUtils.dataQueryByPredicate(type: MovieDetailObject.self, predicate: predicate)
            switch DTPBusiness.shared.movieFilterType {
            case .nameAZ:
                realms = realms.sorted(byKeyPath: "originalTitle", ascending: true)
            case .nameZA:
                realms = realms.sorted(byKeyPath: "originalTitle", ascending: false)
            case .myRating:
                realms = realms.sorted(byKeyPath: "voteAverage", ascending: false)
            default:
                break
            }
            let array = Array(realms)
            let data = Dictionary(grouping: array, by: { $0.firstAirDate })
            self.output?.getMovieFavorite(data)
        }
    }
    
}
