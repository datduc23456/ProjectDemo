//
//  UserNoteInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import Foundation

final class UserNoteInteractor {
    var realmUtils: RealmUtils = AppDelegate.shared.realmUtils
    weak var output: UserNoteInteractorOutputInterface?
}

extension UserNoteInteractor: UserNoteInteractorInterface {
    func fetchMyReview(_ id: Int) {
        let predicate = NSPredicate(format: "movieId == %@", NSNumber(value: id))
        let query = realmUtils.dataQueryByPredicate(type: ReviewsResultObject.self, predicate: predicate)
        self.output?.getMyReviews(Array(query))
    }
}
