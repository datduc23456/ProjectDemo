//
//  ActionWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ActionWireframe: ActionWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "ActionViewController", bundle: nil).instantiateInitialViewController() as! ActionViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! ActionViewController
        let wireframe = ActionWireframe()
        let interactor = ActionInteractor()
        let presenter = ActionPresenter(
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