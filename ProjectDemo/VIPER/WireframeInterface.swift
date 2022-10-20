//
//  WireframeInterface.swift
//  ArrvisCore
//
//  Created by dat.nguyenquoc on 2018/02/08.
// 
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos
import RxSwift

private var imagePickerDelegateKey = 0
private var disposeBagKey = 1

public protocol WireframeInterface: AnyObject, ErrorHandleable {

    /// Navigator
//    var navigator: BaseNavigator {get}

    /// モジュール生成
    ///
    /// - Parameter payload: ペイロード
    /// - Returns: UIViewController
    static func generateModule(_ payload: Any?) -> UIViewController
}

