//
//  Binding+OnlyNumber.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 16/8/24.
//

import SwiftUI

// MARK: - Binding + OnlyNumbers

extension Binding where Value == String {
    var allowOnlyNumbers: Self {
        DispatchQueue.main.async {
            let filtered = wrappedValue.filter { $0.isNumber }
            if filtered != wrappedValue {
                wrappedValue = filtered
            }
        }
        return self
    }
    
    var allowOnlyDecimalNumbers: Self {
        DispatchQueue.main.async {
            let filtered = wrappedValue.filter { $0.isNumber || $0 == "." }
            if filtered != wrappedValue {
                wrappedValue = filtered
            }
        }
        return self
    }
}
