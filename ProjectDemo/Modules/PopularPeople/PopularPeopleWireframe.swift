//
//  PopularPeopleWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class PopularPeopleWireframe: PopularPeopleWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "PopularPeopleViewController", bundle: nil).instantiateInitialViewController() as! PopularPeopleViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! PopularPeopleViewController
        let wireframe = PopularPeopleWireframe()
        let interactor = PopularPeopleInteractor()
        let presenter = PopularPeoplePresenter(
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
