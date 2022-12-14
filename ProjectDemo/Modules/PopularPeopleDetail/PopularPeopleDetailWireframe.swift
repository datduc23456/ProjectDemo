//
//  PopularPeopleDetailWireframe.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class PopularPeopleDetailWireframe: PopularPeopleDetailWireframeInterface {
    var navigator: BaseNavigator!
    

    static func generateModule(_ payload: Any?) -> UIViewController {
        let initialViewController = UIStoryboard(name: "PopularPeopleDetailViewController", bundle: nil).instantiateInitialViewController() as! PopularPeopleDetailViewController
        initialViewController.payload = payload
        // let vc = initialViewController.topViewController as! PopularPeopleDetailViewController
        let wireframe = PopularPeopleDetailWireframe()
        wireframe.navigator = BaseNavigator()
        wireframe.navigator.delegate = initialViewController
        let interactor = PopularPeopleDetailInteractor()
        let presenter = PopularPeopleDetailPresenter(
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
