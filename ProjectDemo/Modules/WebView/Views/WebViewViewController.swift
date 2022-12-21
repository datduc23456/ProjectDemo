//
//  WebViewViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

final class WebViewViewController: BaseViewController {

    // MARK: - Properties
	var presenter: WebViewPresenterInterface!
    var webView: WKWebView!
    
    var titleString: String? {
        if let string = payload as? String {
            return string
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.didPopViewController(nil, true)
        }
        navigation.lbTitle.text = titleString
        webView = WKWebView(frame: .zero)
        self.view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(myNavigationBar!.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        let url = URL(string: "https://www.termsfeed.com/live/42c4732e-7915-40dd-8181-9fcdd0acfce6")!
        webView!.load(URLRequest(url: url))
    }
}

// MARK: - WebViewViewInterface
extension WebViewViewController: WebViewViewInterface {
    
}
