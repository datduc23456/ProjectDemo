//
//  MovieDetailInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class MovieDetailInteractor {

    weak var output: MovieDetailInteractorOutputInterface?
}

extension MovieDetailInteractor: MovieDetailInteractorInterface {
    
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
}
