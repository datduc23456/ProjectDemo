//
//  TVShowPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class TVShowPresenter {

    private weak var view: TVShowViewInterface?
    private var interactor: TVShowInteractorInterface
    private var wireframe: TVShowWireframeInterface

    init(view: TVShowViewInterface,
         interactor: TVShowInteractorInterface,
         wireframe: TVShowWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension TVShowPresenter: TVShowPresenterInterface {
}

extension TVShowPresenter: TVShowInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
