//
//  WebViewPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class WebViewPresenter {

    private weak var view: WebViewViewInterface?
    private var interactor: WebViewInteractorInterface
    private var wireframe: WebViewWireframeInterface

    init(view: WebViewViewInterface,
         interactor: WebViewInteractorInterface,
         wireframe: WebViewWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension WebViewPresenter: WebViewPresenterInterface {
}

extension WebViewPresenter: WebViewInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
