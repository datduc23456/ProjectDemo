//
//  GenersWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 26/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class GenersWireframe: GenersWireframeInterface {
    var navigator: BaseNavigator!
    
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "GenersViewController", bundle: nil).instantiateInitialViewController() as! GenersViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! GenersViewController
        let wireframe = GenersWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = GenersInteractor()
        let presenter = GenersPresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }

	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
    
    func showActionScreen(_ type: ActionViewType) {
        navigator.pushScreen(AppScreens.action, type, fromRoot: true)
    }
}
