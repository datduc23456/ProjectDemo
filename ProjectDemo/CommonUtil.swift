//
//  CommonUtil.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 16/11/2022.
//

import Foundation

class CommonUtil {
    static var SCREEN_WIDTH: CGFloat {
        return (AppDelegate.shared.window?.bounds.width)!
    }
    
    static func getYearFromDate(_ dateString: String) -> String {
        let date = dateString.toDate()
        return "\((date?.get(.year)).isNil(value: 2022))"
    }
    
    static func getThumbnailYoutubeUrl(_ key: String) -> URL {
        return URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")!
    }
}

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
