//
//  TVShowPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class TVShowPresenter {

    private weak var view: TVShowViewInterface?
    private var interactor: TVShowInteractorInterface
    private var wireframe: TVShowWireframeInterface

    init(view: TVShowViewInterface,
         interactor: TVShowInteractorInterface,
         wireframe: TVShowWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension TVShowPresenter: TVShowPresenterInterface {
    func viewDidLoad() {
        interactor.getTVShowPopular()
        interactor.getTVShowLastest()
        interactor.getTopRate()
    }
    
    func didTapToMovie(_ movie: Movie) {
        wireframe.showMovieDetailScreen(movie.id)
    }
    
    func didTapHeaderView(_ section: TVShowTableViewDataSource) {
        switch section {
        case .popular:
            wireframe.showActionScreen(.tvshowpopular)
        case .topRating:
            wireframe.showActionScreen(.tvshowtoprated)
//        case .trending:
//            wireframe.showActionScreen(.moviepopular)
        default:
            return
        }
    }
}

extension TVShowPresenter: TVShowInteractorOutputInterface {
    
    func getTopRate(_ response: MovieResponse) {
        view?.getTopRate(response)
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        view?.getTVShowPopular(response)
    }
    
    func getTVShowLastest(_ response: MovieResponse) {
        view?.getTVShowLastest(response)
    }

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
