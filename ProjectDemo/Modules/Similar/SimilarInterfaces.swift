//
//  SimilarInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol SimilarViewInterface: ViewInterface {
    var info: (id: Int, isTVShow: Bool) { get }
    var peopleDetail: PeopleDetail? { get }
    func getMovie(_ response: MovieResponse)
}

protocol SimilarPresenterInterface: PresenterInterface {
    func didRefresh()
    func didLoadMore(_ page: Int)
    func didTapMovie(_ movie: Movie)
}

protocol SimilarInteractorInterface: InteractorInterface {
    func getSimlarMovie(_ movieId: Int, _ page: Int)
    func getSimlarTVShow(_ tvId: Int, _ page: Int)
    func getSimilarMovieWithPeople(_ peopleId: Int, _ page: Int)
}

protocol SimilarInteractorOutputInterface: InteractorOutputInterface {
    func getMovie(_ response: MovieResponse)
}

protocol SimilarWireframeInterface: WireframeInterface {
    func showMovieDetailScreen(_ id: Int, _ isTVShow: Bool)
}
