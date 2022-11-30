//
//  ImagesWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 30/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ImagesWireframe: ImagesWireframeInterface {
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "ImagesViewController", bundle: nil).instantiateInitialViewController() as! ImagesViewController
        initialViewController.payload = payload
	initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! ImagesViewController
        let wireframe = ImagesWireframe()
	wireframe.navigator = BaseNavigator()
	wireframe.navigator.delegate = initialViewController
        let interactor = ImagesInteractor()
        let presenter = ImagesPresenter(
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
