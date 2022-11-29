//
//  GenersPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 26/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class GenersPresenter {

    private weak var view: GenersViewInterface?
    private var interactor: GenersInteractorInterface
    private var wireframe: GenersWireframeInterface

    init(view: GenersViewInterface,
         interactor: GenersInteractorInterface,
         wireframe: GenersWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension GenersPresenter: GenersPresenterInterface {
}

extension GenersPresenter: GenersInteractorOutputInterface {
    
    func didTapGenres(_ genre: Genre) {
        wireframe.showActionScreen(.genre(genre))
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
