//
//  PlayVideoPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 26/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class PlayVideoPresenter {

    private weak var view: PlayVideoViewInterface?
    private var interactor: PlayVideoInteractorInterface
    private var wireframe: PlayVideoWireframeInterface

    init(view: PlayVideoViewInterface,
         interactor: PlayVideoInteractorInterface,
         wireframe: PlayVideoWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension PlayVideoPresenter: PlayVideoPresenterInterface {
}

extension PlayVideoPresenter: PlayVideoInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
