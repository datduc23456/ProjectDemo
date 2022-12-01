//
//  UserNoteWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class UserNoteWireframe: UserNoteWireframeInterface {
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "UserNoteViewController", bundle: nil).instantiateInitialViewController() as! UserNoteViewController
        initialViewController.payload = payload
	initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! UserNoteViewController
        let wireframe = UserNoteWireframe()
	wireframe.navigator = BaseNavigator()
	wireframe.navigator.delegate = initialViewController
        let interactor = UserNoteInteractor()
        let presenter = UserNotePresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }
    
    func showAddNoteScreen(_ payload: Any) {
        navigator.pushScreen(AppScreens.addnote, payload, fromRoot: true)
    }
    
	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
}
