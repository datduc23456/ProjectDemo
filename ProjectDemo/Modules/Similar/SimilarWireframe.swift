//
//  SimilarWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SimilarWireframe: SimilarWireframeInterface {
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "SimilarViewController", bundle: nil).instantiateInitialViewController() as! SimilarViewController
        initialViewController.payload = payload
	initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! SimilarViewController
        let wireframe = SimilarWireframe()
	wireframe.navigator = BaseNavigator()
	wireframe.navigator.delegate = initialViewController
        let interactor = SimilarInteractor()
        let presenter = SimilarPresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }

	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
    
    func showMovieDetailScreen(_ id: Int, _ isTVShow: Bool) {
        navigator.pushScreen(AppScreens.detail, (id, isTVShow), fromRoot: true)
    }
}
