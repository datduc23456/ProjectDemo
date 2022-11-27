//
//  TVShowInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class TVShowInteractor {

    weak var output: TVShowInteractorOutputInterface?
}

extension TVShowInteractor: TVShowInteractorInterface {
    
    func getTopRate() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowTopRate(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTopRate(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowPopular() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowPopular(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowPopular(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
    
    func getTVShowLastest() {
        ServiceCore.shared.request(MovieResponse.self, targetType: CoreTargetType.TVshowLastest(page: 1), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getTVShowLastest(response)
        }, failureBlock: { error in
            self.output?.handleError(error, {})
        })
    }
}
