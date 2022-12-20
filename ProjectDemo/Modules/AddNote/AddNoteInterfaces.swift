//
//  AddNoteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol AddNoteViewInterface: ViewInterface {
    var movieDetail: MovieDetail? { get }
    func didInsertReviewsResultObject(_ review: ReviewsResultObject)
}

protocol AddNotePresenterInterface: PresenterInterface {
    func didTapDone(_ review: ReviewsResultObject)
    func didTapSearch()
    func didChangeMovie()
}

protocol AddNoteInteractorInterface: InteractorInterface {
    func insertReviewsResultObject(_ review: ReviewsResultObject)
}

protocol AddNoteInteractorOutputInterface: InteractorOutputInterface {
    func insertReviewsResultObject(_ review: ReviewsResultObject)
}

protocol AddNoteWireframeInterface: WireframeInterface {
    func showSearchScreen()
}
