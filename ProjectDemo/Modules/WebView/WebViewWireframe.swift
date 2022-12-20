//
//  WebViewWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class WebViewWireframe: WebViewWireframeInterface {
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
	var storyboardName = "WebViewViewController"
        if UIDevice.current.userInterfaceIdiom == .pad {
            storyboardName = "WebViewViewController_iPad"
        }
        let initialViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as! WebViewViewController
        initialViewController.payload = payload
	initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! WebViewViewController
        let wireframe = WebViewWireframe()
	wireframe.navigator = BaseNavigator()
	wireframe.navigator.delegate = initialViewController
        let interactor = WebViewInteractor()
        let presenter = WebViewPresenter(
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
