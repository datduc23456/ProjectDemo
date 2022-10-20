//
//  ExtensionUseful.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 19/10/2022.
//

import Foundation

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
