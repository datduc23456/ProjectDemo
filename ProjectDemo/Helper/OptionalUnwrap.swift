//
//  OptionalUnwrap.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 24/12/2022.
//

import Foundation

@propertyWrapper
struct OptionalUnwrap<Value> {
    private let defaultValue: Value
    private let optionalValue: Value?
    
    var wrappedValue: Value {
        if let optionalValue {
            return optionalValue
        }
        return defaultValue
    }
    
    init(defaultValue: Value, _ optionalValue: Value?) {
        self.defaultValue = defaultValue
        self.optionalValue = optionalValue
    }
}
