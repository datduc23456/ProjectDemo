//
//  MovieDetailWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class MovieDetailWireframe: MovieDetailWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "MovieDetailViewController", bundle: nil).instantiateInitialViewController() as! MovieDetailViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! MovieDetailViewController
        let wireframe = MovieDetailWireframe()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(
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