//
//  NoteInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class NoteInteractor {
    var realmUtils: RealmUtils! {
        get {
            AppDelegate.shared.realmUtils!
        }
    }
    weak var output: NoteInteractorOutputInterface?
}

extension NoteInteractor: NoteInteractorInterface {
    
    func getMyReviews() {
        var query = realmUtils.dataQuery(type: ReviewsResultObject.self)
        query = query.sorted(byKeyPath: "createdAt", ascending: false)
        let reviews = Array(query)
        self.output?.getMyReviews(reviews)
    }
    
}
