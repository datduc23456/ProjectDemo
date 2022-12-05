//
//  WatchedListWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 04/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class WatchedListWireframe: WatchedListWireframeInterface {
    
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "WatchedListViewController", bundle: nil).instantiateInitialViewController() as! WatchedListViewController
//        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! WatchedListViewController
        let wireframe = WatchedListWireframe()
        wireframe.navigator = BaseNavigator()
//        wireframe.navigator.delegate = initialViewController
        let interactor = WatchedListInteractor()
        let presenter = WatchedListPresenter(
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
