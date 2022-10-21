//
//  BaseViewController.swift
//  ArrvisCore
//
//  Created by Nguyễn Đạt on 2018/02/05.
//
//

import UIKit

open class BaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
//        initializePopGesture()
//        handleDidFirstLayoutSubviews()
//        handleViewWillLayoutSubviews {}
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
