//
//  ActionInteractor.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class ActionInteractor {
    weak var output: ActionInteractorOutputInterface?
}

extension ActionInteractor: ActionInteractorInterface {
    
    func getMoviePopular(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.popular(page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getTopRate(_ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.movieTopRated(page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTopRate(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getMoviePopular(genreId: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.moviegenreid(genreId: genreId), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMoviePopular(response)
        }, failureBlock: { _ in
            
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
}
