//
//  HomeWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class HomeWireframe: HomeWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateInitialViewController() as! HomeViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! HomeViewController
        let wireframe = HomeWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = HomeInteractor()
        let presenter = HomePresenter(
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
    
    func showSearchScreen() {
        navigator.pushScreen(AppScreens.search, SearchType.detail, fromRoot: true)
    }
    
    func showSettingScreen() {
        navigator.pushScreen(AppScreens.setting, fromRoot: true)
    }
    
    func showActionScreen(_ type: ActionViewType) {
        navigator.pushScreen(AppScreens.action, type, fromRoot: true)
    }
    
    func showGenersScreen() {
        navigator.pushScreen(AppScreens.genres, fromRoot: true)
    }
}
