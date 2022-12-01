//
//  FavoriteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol FavoriteViewInterface: ViewInterface {
    func getMovieFavorite(_ data: [String: [MovieDetailObject]])
}

protocol FavoritePresenterInterface: PresenterInterface {
    func getMovieFavorite(_ type: FavoriteFilterType)
    func didTapSearch()
}

protocol FavoriteInteractorInterface: InteractorInterface {
    func getMovieFavorite(_ type: FavoriteFilterType)
}

protocol FavoriteInteractorOutputInterface: InteractorOutputInterface {
    func getMovieFavorite(_ data: [String: [MovieDetailObject]])
}

protocol FavoriteWireframeInterface: WireframeInterface {
    func showSearchScreen()
}
