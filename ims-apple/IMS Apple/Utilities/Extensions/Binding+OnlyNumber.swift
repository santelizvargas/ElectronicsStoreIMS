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
            self.wrappedValue = self.wrappedValue.filter { $0.isNumber }
        }
        return self
    }
}
