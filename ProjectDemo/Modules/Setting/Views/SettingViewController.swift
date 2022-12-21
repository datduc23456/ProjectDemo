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
        
        viewPrivacy.addTapGestureRecognizer {
            let url = URL(string: "mailto:datnq@proxglobal.com)")!
            UIApplication.shared.open(url)
        }
        
        viewShareApp.addTapGestureRecognizer {
            // Setting description
//                let firstActivityItem = "Description"

                // Setting url
                let secondActivityItem : NSURL = NSURL(string: "https://apps.apple.com/us/app/facebook/id284882215")!
                
                // If you want to use an image
//                let image : UIImage = UIImage(named: "Black_adam")!
                let activityViewController : UIActivityViewController = UIActivityViewController(
                    activityItems: [secondActivityItem], applicationActivities: nil)
                
                // This lines is for the popover you need to show in iPad
                activityViewController.popoverPresentationController?.sourceView = self.viewShareApp
                
                // This line remove the arrow of the popover to show in iPad
                activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                
                // Pre-configuring activity items
                activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
                ] as? UIActivityItemsConfigurationReading
                
                // Anything you want to exclude
                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.postToWeibo,
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo,
                    UIActivity.ActivityType.postToFacebook
                ]
                
                activityViewController.isModalInPresentation = true
                self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

// MARK: - SettingViewInterface
extension SettingViewController: SettingViewInterface {
}
