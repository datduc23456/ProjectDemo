//
//  ActionPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class ActionPresenter {

    private weak var view: ActionViewInterface?
    private var interactor: ActionInteractorInterface
    private var wireframe: ActionWireframeInterface

    init(view: ActionViewInterface,
         interactor: ActionInteractorInterface,
         wireframe: ActionWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension ActionPresenter: ActionPresenterInterface {
}

extension ActionPresenter: ActionInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
