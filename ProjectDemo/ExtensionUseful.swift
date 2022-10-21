//
//  ExtensionUseful.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 19/10/2022.
//

import Foundation
import UIKit

private var payloadKey = 1

extension Optional {
    func isNil(value: Wrapped) -> Wrapped {
        if self != nil {
            return self!  // `as!` is unnecessary
        }
        return value
    }
}

extension Array {
    func dictionary<Key, Value>(withKey key: KeyPath<Element, Key>, value: KeyPath<Element, Value>) -> [Key: Value] {
        return reduce(into: [:]) { dictionary, element in
            let key = element[keyPath: key]
            let value = element[keyPath: value]
            dictionary[key] = value
        }
    }
}

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

extension Data {
    func tranforms<T: Decodable>(to: T.Type) -> T? {
        guard let response = try? JSONDecoder().decode(to, from: self) else { return nil }
        return response
    }
    
    func tranforms1<T: Decodable>(to: T.Type) -> T? {
        return try! JSONDecoder().decode(to, from: self)
    }
    
    func toDictionary() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func debug() {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let datatwo = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let printableJson = String(data: datatwo, encoding: .utf8)
            print("Json From Data:\n\(printableJson ?? "null")")
        } catch {
            print("Json From Data: ?? :D ??")
        }
    }
}

extension UIViewController {
    public var payload: Any? {
        get {
            return objc_getAssociatedObject(self, &payloadKey)
        }
        set {
            objc_setAssociatedObject(self, &payloadKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            if let nav = self as? UINavigationController {
                nav.viewControllers.first?.payload = newValue
            }
            if let tab = self as? UITabBarController {
                tab.viewControllers?.forEach({ vc in
                    vc.payload = newValue
                })
            }
        }
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.frame
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController {
    func appWindow() -> UIWindow {
        return ((UIApplication.shared.delegate?.window)!)!
    }
}
