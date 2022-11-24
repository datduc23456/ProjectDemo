//
//  PopularPeoplePresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class PopularPeoplePresenter {

    private weak var view: PopularPeopleViewInterface?
    private var interactor: PopularPeopleInteractorInterface
    private var wireframe: PopularPeopleWireframeInterface

    init(view: PopularPeopleViewInterface,
         interactor: PopularPeopleInteractorInterface,
         wireframe: PopularPeopleWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension PopularPeoplePresenter: PopularPeoplePresenterInterface {
}

extension PopularPeoplePresenter: PopularPeopleInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
