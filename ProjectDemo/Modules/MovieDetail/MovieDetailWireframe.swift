//
//  MovieDetailWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class MovieDetailWireframe: MovieDetailWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "MovieDetailViewController", bundle: nil).instantiateInitialViewController() as! MovieDetailViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! MovieDetailViewController
        let wireframe = MovieDetailWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }

	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
    
    func showPeopleDetail(_ id: Int) {
        navigator.pushScreen(AppScreens.popularpeople, id, fromRoot: true)
    }
    
    func showAddNoteScreen(_ payload: Any) {
        navigator.pushScreen(AppScreens.addnote, payload, fromRoot: true)
    }
    
    func showUserNoteScreen(_ movieDetail: MovieDetail) {
        navigator.pushScreen(AppScreens.usernote, movieDetail, fromRoot: true)
    }
    
    func showSeasonScreen(_ payload: Any) {
        navigator.pushScreen(AppScreens.season, payload, fromRoot: true)
    }
}
