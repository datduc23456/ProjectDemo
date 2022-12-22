//
//  SettingViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class SettingViewController: BaseViewController {

    @IBOutlet weak var viewRatingApp: UIView!
    @IBOutlet weak var viewShareApp: UIView!
    @IBOutlet weak var viewFeedback: UIView!
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
        
        viewFeedback.addTapGestureRecognizer {
            let url = URL(string: "mailto:datnq@proxglobal.com")!
            UIApplication.shared.open(url)
        }
        
        viewRatingApp.addTapGestureRecognizer {
            let url = URL(string: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=284882215")!
            UIApplication.shared.open(url)
        }
        
        viewShareApp.addTapGestureRecognizer {
            CommonUtil.shareApp(self, self.viewShareApp)
        }
    }
    
}

// MARK: - SettingViewInterface
extension SettingViewController: SettingViewInterface {
}
