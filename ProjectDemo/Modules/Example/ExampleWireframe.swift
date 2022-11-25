//
//  ExampleWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ExampleWireframe: ExampleWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "ExampleViewController", bundle: nil).instantiateInitialViewController() as! ExampleViewController
        initialViewController.payload = payload
        let wireframe = ExampleWireframe()
        wireframe.navigator = BaseNavigator()
        let interactor = ExampleInteractor()
        let presenter = ExamplePresenter(
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
