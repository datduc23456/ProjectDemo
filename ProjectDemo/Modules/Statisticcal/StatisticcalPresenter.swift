//
//  StatisticcalPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class StatisticcalPresenter {

    private weak var view: StatisticcalViewInterface?
    private var interactor: StatisticcalInteractorInterface
    private var wireframe: StatisticcalWireframeInterface

    init(view: StatisticcalViewInterface,
         interactor: StatisticcalInteractorInterface,
         wireframe: StatisticcalWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension StatisticcalPresenter: StatisticcalPresenterInterface {
}

extension StatisticcalPresenter: StatisticcalInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
