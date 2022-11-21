//
//  TVShowWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class TVShowWireframe: TVShowWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "TVShowViewController", bundle: nil).instantiateInitialViewController() as! TVShowViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! TVShowViewController
        let wireframe = TVShowWireframe()
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
}
