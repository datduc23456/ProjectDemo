//
//  MovieDetailInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol MovieDetailViewInterface: ViewInterface {
    var id: (Int, Bool) { get }
    func getMovieDetail(_ response: MovieDetail)
    func getTVShowDetail(_ response: MovieDetail)
}

protocol MovieDetailPresenterInterface: PresenterInterface {
    func didTapPlayVideo(_ video: Video)
}

protocol MovieDetailInteractorInterface: InteractorInterface {
    func getMovieDetail(_ id: Int)
    func getTVShowDetail(_ id: Int)
}

protocol MovieDetailInteractorOutputInterface: InteractorOutputInterface {
    func getMovieDetail(_ response: MovieDetail)
    func getTVShowDetail(_ response: MovieDetail)
}

protocol MovieDetailWireframeInterface: WireframeInterface {
}
