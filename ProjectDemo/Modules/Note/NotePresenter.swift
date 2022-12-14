//
//  NotePresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class NotePresenter {

    private weak var view: NoteViewInterface?
    private var interactor: NoteInteractorInterface
    private var wireframe: NoteWireframeInterface

    init(view: NoteViewInterface,
         interactor: NoteInteractorInterface,
         wireframe: NoteWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension NotePresenter: NotePresenterInterface {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear(_ animated: Bool) {
        interactor.getMyReviews()
    }
    
    func didTapSearch() {
        wireframe.showSearchScreen()
    }
    
    func didTapAddNote() {
        wireframe.showAddNoteScreen(nil)
    }
    
    func didRefresh() {
        interactor.getMyReviews()
    }
    
    func showReview(_ review: ReviewsResultObject) {
        wireframe.showAddNoteScreen(review)
    }
    
    func didTapSetting() {
        wireframe.showSettingScreen()
    }
}

extension NotePresenter: NoteInteractorOutputInterface {
    func getMyReviews(_ data: [ReviewsResultObject]) {
        view?.getMyReviews(data)
    }
    

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
