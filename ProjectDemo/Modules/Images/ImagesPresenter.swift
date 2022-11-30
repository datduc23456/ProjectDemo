//
//  ImagesPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 30/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class ImagesPresenter {

    private weak var view: ImagesViewInterface?
    private var interactor: ImagesInteractorInterface
    private var wireframe: ImagesWireframeInterface

    init(view: ImagesViewInterface,
         interactor: ImagesInteractorInterface,
         wireframe: ImagesWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension ImagesPresenter: ImagesPresenterInterface {
}

extension ImagesPresenter: ImagesInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
