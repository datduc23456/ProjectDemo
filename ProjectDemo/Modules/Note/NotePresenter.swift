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
    func didTapAddNote() {
        wireframe.showAddNoteScreen()
    }
}

extension NotePresenter: NoteInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
