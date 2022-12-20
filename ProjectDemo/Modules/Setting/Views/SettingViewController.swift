//
//  SettingViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SettingViewController: BaseViewController {

    @IBOutlet weak var viewPrivacy: UIView!
    @IBOutlet weak var bannerAdView: BannerAdView!
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
        bannerAdView.register(id: "ca-app-pub-3940256099942544/6300978111")
        viewPrivacy.addTapGestureRecognizer {
            self.navigationController?.pushViewController(AppScreens.webView.createViewController(), animated: true)
        }
    }
    
}

// MARK: - SettingViewInterface
extension SettingViewController: SettingViewInterface {
}
