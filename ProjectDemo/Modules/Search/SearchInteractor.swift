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
        }, failureBlock: { _ in
            
        })
    }
    
    func searchPerson(_ query: String) {
        ServiceCore.shared.request(PersonResponse.self, targetType: CoreTargetType.searchPerson(query: query, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchPerson(response.results)
        }, failureBlock: { _ in
            
        })
    }
    
    func searchMoviePopular(_ query: String) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.searchMovie(query: query, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.searchMoviePopular(response.results)
        }, failureBlock: { _ in
            
        })
    }
}
