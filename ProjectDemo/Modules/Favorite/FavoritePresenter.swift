//
//  FavoritePresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class FavoritePresenter {

    private weak var view: FavoriteViewInterface?
    private var interactor: FavoriteInteractorInterface
    private var wireframe: FavoriteWireframeInterface

    init(view: FavoriteViewInterface,
         interactor: FavoriteInteractorInterface,
         wireframe: FavoriteWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension FavoritePresenter: FavoritePresenterInterface {
    func viewDidLoad() {
        
    }
}

extension FavoritePresenter: FavoriteInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
