//
//  FavoriteWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class FavoriteWireframe: FavoriteWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "FavoriteViewController", bundle: nil).instantiateInitialViewController() as! FavoriteViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! FavoriteViewController
        let wireframe = FavoriteWireframe()
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter(
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