//
//  HomePresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class HomePresenter {

    private weak var view: HomeViewInterface?
    private var interactor: HomeInteractorInterface
    private var wireframe: HomeWireframeInterface

    init(view: HomeViewInterface,
         interactor: HomeInteractorInterface,
         wireframe: HomeWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension HomePresenter: HomePresenterInterface {
    
    func viewDidLoad() {
        self.interactor.getMoviePopular()
        self.interactor.getGenresList()
        self.interactor.getTopRate()
    }
    
    func viewWillAppear(_ animated: Bool) {

    }
    
    func didTapToMovie(_ movie: Movie) {
        wireframe.showMovieDetailScreen(movie.id)
    }
    
    func didTapSearch() {
        wireframe.showSearchScreen()
    }
}

extension HomePresenter: HomeInteractorOutputInterface {
    
    func getMoviePopular(_ response: MovieResponse) {
        view?.getMoviePopular(response)
    }
    
    func getGenresList(_ response: GenreResponse) {
        view?.getGenresList(response)
    }
    
    func getTopRate(_ response: MovieResponse) {
        view?.getTopRate(response)
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
