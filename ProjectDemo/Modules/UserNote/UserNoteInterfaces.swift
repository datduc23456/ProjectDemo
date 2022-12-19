//
//  UserNoteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol UserNoteViewInterface: ViewInterface {
    var movieDetail: MovieDetail? { get }
    func getMyReviews(_ data: [ReviewsResultObject])
}

protocol UserNotePresenterInterface: PresenterInterface {
    func didTapAddNote()
}

protocol UserNoteInteractorInterface: InteractorInterface {
    func fetchMyReview(_ id: Int)
}

protocol UserNoteInteractorOutputInterface: InteractorOutputInterface {
    func getMyReviews(_ data: [ReviewsResultObject])
}

protocol UserNoteWireframeInterface: WireframeInterface {
    func showAddNoteScreen(_ payload: Any)
}
