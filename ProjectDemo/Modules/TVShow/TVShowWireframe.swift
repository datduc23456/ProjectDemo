//
//  TVShowWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class TVShowWireframe: TVShowWireframeInterface {
    
    
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "TVShowViewController", bundle: nil).instantiateInitialViewController() as! TVShowViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! TVShowViewController
        let wireframe = TVShowWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = TVShowInteractor()
        let presenter = TVShowPresenter(
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
        AdMobManager.shared.show(key: "RewardedInterstitialAd")
        navigator.pushScreen(AppScreens.detail, (id, true), fromRoot: true)
    }
    
    func showActionScreen(_ type: ActionViewType) {
        navigator.pushScreen(AppScreens.action, type, fromRoot: true)
    }
    
    func showSearchScreen() {
        navigator.pushScreen(AppScreens.search, SearchType.detail, fromRoot: true)
    }
    
    func showSettingScreen() {
        navigator.pushScreen(AppScreens.setting, fromRoot: true)
    }
}
