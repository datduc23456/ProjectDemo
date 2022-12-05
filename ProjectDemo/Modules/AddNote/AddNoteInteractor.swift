//
//  AddNoteInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class AddNoteInteractor {
    let realmUtils = AppDelegate.shared.realmUtils!
    weak var output: AddNoteInteractorOutputInterface?
}

extension AddNoteInteractor: AddNoteInteractorInterface {
    func insertReviewsResultObject(_ review: ReviewsResultObject) {
        self.realmUtils.insertOrUpdate(review)
        self.output?.insertReviewsResultObject(review)
    }
    
    func getMovieDetail(_ id: Int) {
        
    }
    
    func getTVShowDetail(_ id: Int) {
        
    }
}
