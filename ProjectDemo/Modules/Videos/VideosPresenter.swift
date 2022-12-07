//
//  VideosPresenter.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class VideosPresenter {

    private weak var view: VideosViewInterface?
    private var interactor: VideosInteractorInterface
    private var wireframe: VideosWireframeInterface

    init(view: VideosViewInterface,
         interactor: VideosInteractorInterface,
         wireframe: VideosWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension VideosPresenter: VideosPresenterInterface {
    func didTapPlayVideo(_ video: Video) {
        wireframe.showPlayVideo(video.key, false)
    }
}

extension VideosPresenter: VideosInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
