//
//  WatchedListPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 04/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class WatchedListPresenter {

    private weak var view: WatchedListViewInterface?
    private var interactor: WatchedListInteractorInterface
    private var wireframe: WatchedListWireframeInterface

    init(view: WatchedListViewInterface,
         interactor: WatchedListInteractorInterface,
         wireframe: WatchedListWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension WatchedListPresenter: WatchedListPresenterInterface {
}

extension WatchedListPresenter: WatchedListInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
