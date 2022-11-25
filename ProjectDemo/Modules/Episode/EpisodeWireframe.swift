//
//  EpisodeWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class EpisodeWireframe: EpisodeWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "EpisodeViewController", bundle: nil).instantiateInitialViewController() as! EpisodeViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! EpisodeViewController
        let wireframe = EpisodeWireframe()
        wireframe.navigator = BaseNavigator()
        let interactor = EpisodeInteractor()
        let presenter = EpisodePresenter(
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
