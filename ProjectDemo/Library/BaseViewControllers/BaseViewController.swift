//
//  BaseViewController.swift
//  ArrvisCore
//
//  Created by Nguyễn Đạt on 2018/02/05.
//
//

import UIKit
import Moya

open class BaseViewController: UIViewController {

    public var currentRootViewController: UIViewController?
    public private(set) var navigator: BaseNavigator!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
//        initializePopGesture()
//        handleDidFirstLayoutSubviews()
//        handleViewWillLayoutSubviews {}
        self.view.backgroundColor = APP_COLOR
    }
    
    public convenience init(navigator: BaseNavigator) {
        self.init(nibName: nil, bundle: nil)
        self.navigator = navigator
        self.navigator.delegate = self
    }
}

extension BaseViewController {

    private func setBackResultIfCan(vc: UIViewController, result: Any?) {
        guard let backFromNextHandleable = vc as? BackFromNextHandleable else {
            return
        }
        backFromNextHandleable.onBackFromNext(result)
    }
}

extension BaseViewController {

    open func currentViewController(from: UIViewController? = nil) -> UIViewController? {
        if let from = from {
            if let presented = from.presentedViewController {
                return currentViewController(from: presented)
            }
            if let nav = from as? UINavigationController {
                if let last = nav.children.last {
                    return currentViewController(from: last)
                }
                return nav
            }
            if let tab = from as? UITabBarController {
                if let selected = tab.selectedViewController {
                    return currentViewController(from: selected)
                }
                return tab
            }
            return from
        } else if let presented = presentedViewController {
            return currentViewController(from: presented)
        } else if let currentRootViewController = currentRootViewController {
            return currentViewController(from: currentRootViewController)
        } else {
            return nil
        }
    }
}

extension BaseViewController: BaseNavigatorDelegate {
    func didPushViewController(_ vc: UIViewController, _ fromRoot: Bool, _ animate: Bool) {
        
    }

    func didPresentViewController(_ vc: UIViewController, _ animate: Bool) {
        
    }

    func didReplaceViewController(_ vc: UIViewController) {
        
    }

    func didPopViewController(_ result: Any?, _ animate: Bool) {
        
    }

    func didDismissViewController(_ result: Any?, _ animate: Bool) {
        
    }
}
