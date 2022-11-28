//
//  NoteWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class NoteWireframe: NoteWireframeInterface {
	var navigator: BaseNavigator!
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "NoteViewController", bundle: nil).instantiateInitialViewController() as! NoteViewController
        initialViewController.payload = payload
	initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! NoteViewController
        let wireframe = NoteWireframe()
	wireframe.navigator = BaseNavigator()
	wireframe.navigator.delegate = initialViewController
        let interactor = NoteInteractor()
        let presenter = NotePresenter(
            view: initialViewController,
            interactor: interactor,
            wireframe: wireframe)
        interactor.output = presenter
        initialViewController.presenter = presenter
        return initialViewController
    }

	func handleError(_ error: Error, _ completion: (() -> Void)?) {
        
    }
    
    func showAddNoteScreen() {
        navigator.pushScreen(AppScreens.search, SearchType.addnote, fromRoot: true)
    }
}
