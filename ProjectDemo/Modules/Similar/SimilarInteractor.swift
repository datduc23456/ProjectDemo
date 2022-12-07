//
//  SimilarInteractor.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SimilarInteractor {

    weak var output: SimilarInteractorOutputInterface?
}

extension SimilarInteractor: SimilarInteractorInterface {
    func getSimlarMovie(_ movieId: Int, _ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.getSimularMovie(movieId: movieId, page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMovie(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getSimlarTVShow(_ tvId: Int, _ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.getSimularTv(tvId: tvId, page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMovie(response)
        }, failureBlock: { _ in
            
        })
    }
    
    func getSimilarMovieWithPeople(_ peopleId: Int, _ page: Int) {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.moviepeopleid(peopleId: peopleId, page: page), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getMovie(response)
        }, failureBlock: { _ in
            
        })
    }
}
