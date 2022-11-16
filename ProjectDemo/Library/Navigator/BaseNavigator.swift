//
//  BaseNavigator.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//

import UIKit

protocol Navigatable {
    var scheme: String {get}
    var routes: [String] {get}

    func getScreen(path: String) -> Screen
}

protocol BaseNavigatorDelegate: AnyObject {
    func didPushViewController(_ vc: UIViewController, _ fromRoot: Bool, _ animate: Bool)
    func didPresentViewController(_ vc: UIViewController, _ animate: Bool)
    func didReplaceViewController(_ vc: UIViewController)
    func didPopViewController(_ result: Any?, _ animate: Bool)
    func didDismissViewController(_ result: Any?, _ animate: Bool)
}

open class BaseNavigator {
    // MARK: - Variables
    weak var delegate: BaseNavigatorDelegate?
}

extension BaseNavigator {
    public func popScreen(result: Any? = nil, animate: Bool = true) {
        delegate?.didPopViewController(result, animate)
    }

    public func dismissScreen(result: Any? = nil, animate: Bool = true) {
        delegate?.didDismissViewController(result, animate)
    }
}