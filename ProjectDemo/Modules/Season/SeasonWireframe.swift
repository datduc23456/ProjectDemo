//
//  SeasonWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SeasonWireframe: SeasonWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "SeasonViewController", bundle: nil).instantiateInitialViewController() as! SeasonViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! SeasonViewController
        let wireframe = SeasonWireframe()
        let interactor = SeasonInteractor()
        let presenter = SeasonPresenter(
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
