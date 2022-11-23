//
//  StatisticcalWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class StatisticcalWireframe: StatisticcalWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "StatisticcalViewController", bundle: nil).instantiateInitialViewController() as! StatisticcalViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! StatisticcalViewController
        let wireframe = StatisticcalWireframe()
        let interactor = StatisticcalInteractor()
        let presenter = StatisticcalPresenter(
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
