//
//  HomePresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class HomePresenter {

    private weak var view: HomeViewInterface?
    private var interactor: HomeInteractorInterface
    private var wireframe: HomeWireframeInterface

    init(view: HomeViewInterface,
         interactor: HomeInteractorInterface,
         wireframe: HomeWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension HomePresenter: HomePresenterInterface {
}

extension HomePresenter: HomeInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
