//
//  SearchInteractor.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SearchInteractor {

    weak var output: SearchInteractorOutputInterface?
}

extension SearchInteractor: SearchInteractorInterface {
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
