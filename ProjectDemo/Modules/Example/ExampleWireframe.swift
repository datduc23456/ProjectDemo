//
//  ExampleWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ExampleWireframe: ExampleWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = ExampleViewController()
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! ExampleViewController
        let wireframe = ExampleWireframe()
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
