//
//  AppDelegate.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 19/10/2022.
//

import UIKit
import KafkaRefresh
import Network
import FirebaseCore
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var realmUtils: RealmUtils!
    var monitor: NWPathMonitor!
    
    static var shared: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            assertionFailure()
            exit(0)
        }
        return delegate
    }
    
    var navigationRootViewController: UINavigationController {
        return window!.rootViewController as! UINavigationController
    }
    
    var appRootViewController: TabbarViewController {
        return (window!.rootViewController as! UINavigationController).viewControllers.first as! TabbarViewController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let navigation = UINavigationController.init(rootViewController: TabbarViewController())
        navigation.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        self.realmUtils = RealmUtilsProvider.defaultStorage
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetConnected"), object: nil)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetLost"), object: nil)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if monitor.currentPath.status == .satisfied {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetConnected"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetLost"), object: nil)
        }
    }
    
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

