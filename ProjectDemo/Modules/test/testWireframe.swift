//
//  testWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class testWireframe: testWireframeInterface {

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = R.storyboard.testViewController.instantiateInitialViewController()!
        initialViewController.payload = payload
        let vc = initialViewController.topViewController as! testViewController
        let wireframe = testWireframe()
        let interactor = testInteractor()
        let presenter = testPresenter(
            view: vc,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        vc.presenter = presenter
        return initialViewController
    }
}
