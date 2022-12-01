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
        interactor.getMovieFavorite(.movie)
    }
    
    func didTapSearch() {
        wireframe.showSearchScreen()
    }
    
    func getMovieFavorite(_ type: FavoriteFilterType) {
        interactor.getMovieFavorite(type)
    }
}

extension FavoritePresenter: FavoriteInteractorOutputInterface {
    func getMovieFavorite(_ data: [String : [MovieDetailObject]]) {
        view?.getMovieFavorite(data)
    }

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
