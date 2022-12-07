//
//  StatisticcalInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class StatisticcalInteractor {

    weak var output: StatisticcalInteractorOutputInterface?
}

extension StatisticcalInteractor: StatisticcalInteractorInterface {
    func fetchWatchedListObjects() {
        DTPBusiness.shared.fetchWatchedListObjects(completion: { objects in
            self.output?.fetchWatchedListObjects(objects)
        })
    }
    
    func deleteWatchedListObject(_ object: WatchedListObject) {
        DTPBusiness.shared.deleteWatchedListObject(object, completion: { object in
            self.output?.deleteWatchedListObject(object)
        })
    }
}
