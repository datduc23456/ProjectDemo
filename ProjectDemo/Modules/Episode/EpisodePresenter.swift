//
//  EpisodePresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class EpisodePresenter {

    private weak var view: EpisodeViewInterface?
    private var interactor: EpisodeInteractorInterface
    private var wireframe: EpisodeWireframeInterface

    init(view: EpisodeViewInterface,
         interactor: EpisodeInteractorInterface,
         wireframe: EpisodeWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension EpisodePresenter: EpisodePresenterInterface {
}

extension EpisodePresenter: EpisodeInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
