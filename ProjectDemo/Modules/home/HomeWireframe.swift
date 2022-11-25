//
//  HomeWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class HomeWireframe: HomeWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateInitialViewController() as! HomeViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! HomeViewController
        let wireframe = HomeWireframe()
        wireframe.navigator = BaseNavigator()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(
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
