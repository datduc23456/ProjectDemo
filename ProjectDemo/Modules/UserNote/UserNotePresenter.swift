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

    init(view: UserNoteViewInterface,
         interactor: UserNoteInteractorInterface,
         wireframe: UserNoteWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension UserNotePresenter: UserNotePresenterInterface {
}

extension UserNotePresenter: UserNoteInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
