//
//  AddNotePresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class AddNotePresenter {

    private weak var view: AddNoteViewInterface?
    private var interactor: AddNoteInteractorInterface
    private var wireframe: AddNoteWireframeInterface

    init(view: AddNoteViewInterface,
         interactor: AddNoteInteractorInterface,
         wireframe: AddNoteWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension AddNotePresenter: AddNotePresenterInterface {
}

extension AddNotePresenter: AddNoteInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
