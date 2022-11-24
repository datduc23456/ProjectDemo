//
//  SeasonPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SeasonPresenter {

    private weak var view: SeasonViewInterface?
    private var interactor: SeasonInteractorInterface
    private var wireframe: SeasonWireframeInterface

    init(view: SeasonViewInterface,
         interactor: SeasonInteractorInterface,
         wireframe: SeasonWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension SeasonPresenter: SeasonPresenterInterface {
}

extension SeasonPresenter: SeasonInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
