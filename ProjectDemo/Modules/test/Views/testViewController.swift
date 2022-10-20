//
//  testViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class testViewController: AppBaseViewController {

    // MARK: - Properties

    var presenter: testPresenterInterface!

    override var pageHtml: URL? {
        // TODO: 変更してね
        return R.file.indexHtml()
    }

    override var pageCallbacks: [String: (Data?) -> Void] {
        return [
            "foo": { [unowned self] body in
            }
        ]
    }
}

// MARK: - testViewInterface
extension testViewController: testViewInterface {
}
