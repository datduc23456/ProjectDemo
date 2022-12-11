//
//  SearchWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SearchWireframe: SearchWireframeInterface {

    var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateInitialViewController() as! SearchViewController
        initialViewController.payload = payload
        initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! SearchViewController
        let wireframe = SearchWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }

	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
    
    func showMovieDetailScreen(_ id: Int) {
        navigator.pushScreen(AppScreens.detail, (id, false), fromRoot: true)
    }
    
    func showTVShowDetailScreen(_ id: Int) {
        navigator.pushScreen(AppScreens.detail, (id, true), fromRoot: true)
    }
    
    func showAddNoteScreen(_ response: MovieDetail) {
        navigator.pushScreen(AppScreens.addnote, response, fromRoot: true)
    }
    
    func showWatchedListScreen(_ response: MovieDetail) {
        
    }
    
    func showPeopleDetail(_ id: Int) {
        navigator.pushScreen(AppScreens.popularpeople, id, fromRoot: true)
    }
}
