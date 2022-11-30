//
//  PopularPeopleInteractor.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class PopularPeopleInteractor {

    weak var output: PopularPeopleInteractorOutputInterface?
}

extension PopularPeopleInteractor: PopularPeopleInteractorInterface {
    func getTopRate() {
        
    }
    
    
    func getPeopleDetail(_ id: Int) {
        ServiceCore.shared.request(PeopleDetail.self, targetType: CoreTargetType.personDetail(personId: id), successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.output?.getPeopleDetail(response)
        }, failureBlock: { _ in
            
        })
    }
}
