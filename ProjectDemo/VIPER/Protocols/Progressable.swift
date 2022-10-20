//
//  Progressable.swift
//  ArrvisCore
//
//  Created by dat.nguyenquoc on 2018/02/08.
//
//

import UIKit

public protocol Progressable {
    func showLoading()
    func showLoading(message: String)
    func hideLoading()
}

extension Progressable where Self: UIViewController {

    public func showLoading() {
        view.endEditing(true)
        if let superview = view.superview {
//            ActivityIndicatorManager.shared.show(parent: superview)
        } else {
//            NSObject.runAfterDelay(delayMSec: 100) { [weak self] in
//                guard let weakSelf = self else { return }
//                weakSelf.showLoading()
//            }
        }
    }

    public func showLoading(message: String) {
        view.endEditing(true)
        if let superview = view.superview {
//            ActivityIndicatorManager.shared.show(parent: superview, message: message)
        } else {
//            NSObject.runAfterDelay(delayMSec: 100) { [weak self] in
//                guard let weakSelf = self else { return }
//                weakSelf.showLoading(message: message)
//            }
        }
    }

    public func hideLoading() {
//        ActivityIndicatorManager.shared.hide()
    }
}
