//
//  VideosWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class VideosWireframe: VideosWireframeInterface {
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "VideosViewController", bundle: nil).instantiateInitialViewController() as! VideosViewController
        initialViewController.payload = payload
	initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! VideosViewController
        let wireframe = VideosWireframe()
	wireframe.navigator = BaseNavigator()
	wireframe.navigator.delegate = initialViewController
        let interactor = VideosInteractor()
        let presenter = VideosPresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }

	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
}
