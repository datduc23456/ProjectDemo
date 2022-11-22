//
//  MovieDetailPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class MovieDetailPresenter {

    private weak var view: MovieDetailViewInterface?
    private var interactor: MovieDetailInteractorInterface
    private var wireframe: MovieDetailWireframeInterface

    init(view: MovieDetailViewInterface,
         interactor: MovieDetailInteractorInterface,
         wireframe: MovieDetailWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
}

extension MovieDetailPresenter: MovieDetailInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
