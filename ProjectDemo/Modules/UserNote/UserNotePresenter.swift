//
//  UserNotePresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class UserNotePresenter {

    private weak var view: UserNoteViewInterface?
    private var interactor: UserNoteInteractorInterface
    private var wireframe: UserNoteWireframeInterface
    private var reviewsObject: [ReviewsResultObject] = []
    init(view: UserNoteViewInterface,
         interactor: UserNoteInteractorInterface,
         wireframe: UserNoteWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension UserNotePresenter: UserNotePresenterInterface {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear(_ animated: Bool) {
        if let movieDetail = view?.movieDetail {
            interactor.fetchMyReview(movieDetail.id)
        }
    }
    
    func didTapAddNote() {
        if let movieDetail = view?.movieDetail {
            wireframe.showAddNoteScreen(movieDetail)
        }
//        else {
//            wireframe.showAddNoteScreen(reviewsObject[0])
//        }
    }
    
}

extension UserNotePresenter: UserNoteInteractorOutputInterface {
    func getMyReviews(_ data: [ReviewsResultObject]) {
        self.reviewsObject = data
        view?.getMyReviews(data)
    }

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
