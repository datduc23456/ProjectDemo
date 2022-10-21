//
//  BaseNavigator.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//

import UIKit
public protocol Screen {
    var path: String { get }
    var transition: NavigateTransions { get }
    func createViewController(_ payload: Any?) -> UIViewController
}

public enum NavigateTransions: String {
    case replace
    case push
    case present
}
