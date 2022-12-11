//
//  SettingWireframe.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SettingWireframe: SettingWireframeInterface {
	var navigator: BaseNavigator!
    
    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "SettingViewController", bundle: nil).instantiateInitialViewController() as! SettingViewController
        let navigator = BaseNavigator()
        initialViewController.payload = payload
        initialViewController.modalPresentationStyle = .fullScreen
        // let vc = initialViewController.topViewController as! SettingViewController
        let wireframe = SettingWireframe()
        wireframe.navigator = navigator
        wireframe.navigator.delegate = initialViewController
        let interactor = SettingInteractor()
        let presenter = SettingPresenter(
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
