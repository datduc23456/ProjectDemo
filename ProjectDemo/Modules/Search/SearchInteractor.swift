//
//  SearchInteractor.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SearchInteractor {
    var realmUtils: RealmUtils! {
        get {
            AppDelegate.shared.realmUtils!
        }
    }
    weak var output: SearchInteractorOutputInterface?
}

extension SearchInteractor: SearchInteractorInterface {
    func insertQuery(_ query: String) {
        let searchKeyObject = SearchKeyObject()
        searchKeyObject.key = query
        realmUtils.insert(searchKeyObject)
    }
    
    func fetchSearchKey() {
        self.output?.fetchSearchKey(realmUtils.getListObjects(type: SearchKeyObject.self))
    }
    
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
    
    func searchTVShowPopular(_ query: String) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.searchTVshow(query: query, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchTVShowPopular(response.results)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func searchPerson(_ query: String) {
        ServiceCore.shared.request(PersonResponse.self, targetType: CoreTargetType.searchPerson(query: query, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchPerson(response.results)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func searchMoviePopular(_ query: String) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.searchMovie(query: query, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchMoviePopular(response.results)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func searchMoviePopularWithGenre(genreId: Int, _ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.moviegenreid(genreId: genreId, page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchMoviePopularWithGenre(response.results)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func searchTVShowPopularWithGenre(genreId: Int, _ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowgenreid(genreId: genreId, page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchTVShowPopularWithGenre(response.results)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
}
