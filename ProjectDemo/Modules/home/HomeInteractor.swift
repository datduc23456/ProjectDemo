//
//  HomeInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class HomeInteractor {

    weak var output: HomeInteractorOutputInterface?
}

extension HomeInteractor: HomeInteractorInterface {
    
    func getMoviePopular() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.popular(1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getGenresList() {
        ServiceCore.shared.request(GenreResponse.self, targetType: CoreTargetType.genreList, successBlock: { [weak self] response in
            guard let `self` = self else { return }
            DTPBusiness.shared.listGenres = response.genres
            self.output?.getGenresList(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getTopRate() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.movieTopRated(1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTopRate(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getMoviePopular(_ genreId: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.moviegenreid(genreId: genreId, page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
        }, failureBlock: { _ in
            
        })
    }
}
