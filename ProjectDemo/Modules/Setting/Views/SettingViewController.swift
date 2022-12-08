//
//  SettingViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SettingViewController: BaseViewController {

    // MARK: - Properties
	var presenter: SettingPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.didPopViewController(nil, true)
        }
        navigation.lbTitle.text = "Setting"
    }
    
}

// MARK: - SettingViewInterface
extension SettingViewController: SettingViewInterface {
}
