//
//  NoteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol NoteViewInterface: ViewInterface {
    func getMyReviews(_ data: [ReviewsResultObject])
}

protocol NotePresenterInterface: PresenterInterface {
    func didRefresh()
    func didTapAddNote()
    func didTapSearch()
    func showReview(_ review: ReviewsResultObject)
}

protocol NoteInteractorInterface: InteractorInterface {
    func getMyReviews()
}

protocol NoteInteractorOutputInterface: InteractorOutputInterface {
    func getMyReviews(_ data: [ReviewsResultObject])
}

protocol NoteWireframeInterface: WireframeInterface {
    func showAddNoteScreen(_ payload: Any?)
    func showSearchScreen()
}
