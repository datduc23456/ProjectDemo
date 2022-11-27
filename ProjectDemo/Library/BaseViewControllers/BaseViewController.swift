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
    
    var realmUtils: RealmUtils! {
        get {
            AppDelegate.shared.realmUtils
        }
    }
    var myNavigationBar: NavigationBarView?
    public var currentRootViewController: UIViewController?
    public private(set) var navigator: BaseNavigator!
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
//        initializePopGesture()
//        handleDidFirstLayoutSubviews()
//        handleViewWillLayoutSubviews {}
        self.view.backgroundColor = APP_COLOR
    }
    
    private var currentRootNavigationController: UINavigationController? {
        if let current = currentRootViewController as? UINavigationController {
            return current
        } else if let current = currentRootViewController as? UITabBarController,
            let selected = current.selectedViewController as? UINavigationController {
            return selected
        }
        return nil
    }
    
    public convenience init(navigator: BaseNavigator) {
        self.init(nibName: nil, bundle: nil)
        self.navigator = navigator
        self.navigator.delegate = self
    }
    
    func initCustomNavigation<T:NavigationBarView>(_ type: NavigationBarType) -> T {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let nav = NavigationBarView.initUsingAutoLayout(type, view: view) as! T
        myNavigationBar = nav
        return nav
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
    
    /// Push
    public func pushChildViewController(_ vc: UIViewController, _ fromRoot: Bool, _ animate: Bool) {
        if fromRoot {
            AppDelegate.shared.appRootViewController.navigationController?.pushViewController(vc, animated: animate)
        } else {
            currentNavigationController(from: nil)?.pushViewController(vc, animated: animate)
        }
    }
    
    /// Pop
    public func popChildViewController(_ result: Any?, _ animate: Bool) {
        currentViewController()?.navigationController?.popViewController(animated: animate)

        func completed() {
            if let current = currentViewController() {
                setBackResultIfCan(vc: current, result: result)
            }
        }

        if let coordinator = currentViewController()?.navigationController?.transitionCoordinator, animate {
            coordinator.animate(alongsideTransition: nil) { _ in
                completed()
            }
        } else {
            completed()
        }
    }
    
    /// Present
    public func presentChildViewController(_ vc: UIViewController, _ animate: Bool) {
        currentViewController()?.present(vc, animated: animate)
    }

    /// Dismiss
    public func dismisssChildViewController(_ result: Any?, _ animate: Bool, _ completion: (() -> Void)? = nil) {
        currentViewController()?.dismiss(animated: animate, completion: { [weak self] in
            guard let weakSelf = self else { return }
            if let current = weakSelf.currentViewController() {
                weakSelf.setBackResultIfCan(vc: current, result: result)
            }
            completion?()
        })
    }
}

extension BaseViewController {

    public func currentViewController(from: UIViewController? = nil) -> UIViewController? {
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
    
    func currentNavigationController(from: UIViewController?) -> UINavigationController? {
        if let from = from {
            if let nav = from as? UINavigationController {
                return nav
            }
            if let navigationController = from.navigationController {
                return navigationController
            }
            if let parent = from.parent {
                return currentNavigationController(from: parent)
            }
            return nil
        } else {
            return currentNavigationController(from: currentViewController(from: from)!)
        }
    }
}

extension BaseViewController: BaseNavigatorDelegate {
    func didPushViewController(_ vc: UIViewController, _ fromRoot: Bool, _ animate: Bool) {
        self.pushChildViewController(vc, fromRoot, animate)
    }

    func didPresentViewController(_ vc: UIViewController, _ animate: Bool) {
        self.present(vc, animated: true)
    }

    func didReplaceViewController(_ vc: UIViewController) {
        
    }

    func didPopViewController(_ result: Any?, _ animate: Bool) {
        
    }

    func didDismissViewController(_ result: Any?, _ animate: Bool) {
        
    }
}
