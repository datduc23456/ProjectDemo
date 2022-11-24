//
//  PopularPeopleDetailPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class PopularPeopleDetailPresenter {

    private weak var view: PopularPeopleDetailViewInterface?
    private var interactor: PopularPeopleDetailInteractorInterface
    private var wireframe: PopularPeopleDetailWireframeInterface

    init(view: PopularPeopleDetailViewInterface,
         interactor: PopularPeopleDetailInteractorInterface,
         wireframe: PopularPeopleDetailWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension PopularPeopleDetailPresenter: PopularPeopleDetailPresenterInterface {
}

extension PopularPeopleDetailPresenter: PopularPeopleDetailInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
