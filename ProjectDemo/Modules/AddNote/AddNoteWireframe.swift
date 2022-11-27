//
//  AddNoteWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class AddNoteWireframe: AddNoteWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "AddNoteViewController", bundle: nil).instantiateInitialViewController() as! AddNoteViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! AddNoteViewController
        let wireframe = AddNoteWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = AddNoteInteractor()
        let presenter = AddNotePresenter(
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
