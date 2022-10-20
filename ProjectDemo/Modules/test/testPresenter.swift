//
//  testPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class testPresenter {

    private weak var view: testViewInterface?
    private var interactor: testInteractorInterface
    private var wireframe: testWireframeInterface

    init(view: testViewInterface,
         interactor: testInteractorInterface,
         wireframe: testWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension testPresenter: testPresenterInterface {
}

extension testPresenter: testInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
