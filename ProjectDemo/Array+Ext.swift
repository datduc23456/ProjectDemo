//
//  Array+Ext.swift
//  MVVMRx
//
//  Created by Nguyễn Đạt on 10/12/20.
//  Copyright © 2020 storm. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Array where Element == Node {
    func difference(from other: [Element]) -> [Element] {
        let temp = self.filter({ !other.containId(id: $0.uid ?? "0") })
        return temp
    }
    
    func containId(id: String) -> Bool {
        for node in self {
            if node.uid == id {
                return true
            }
        }
        return false
    }
}

extension Array where Element == Route {
    
    func appendEdges(edge: Edge) {
       if self.isEmpty {
           return
       }
       let firstRoute = self.first!
        firstRoute.edges.insert(edge, at: 0)
        for index in 1..<self.count {
            let route = self[index]
            if route.firstNode == nil{
               route.edges.insert(edge, at: 0)
           }
       }
   }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

extension Array where Element == Assignment {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && (self.map({ $0.id ?? 0 }).sorted() == other.map({ $0.id ?? 0 }).sorted())
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
