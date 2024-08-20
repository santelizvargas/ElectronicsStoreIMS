//
//  Binding+OnlyNumber.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 16/8/24.
//

import SwiftUI


// MARK: - Binding + OnlyNumbers

extension Binding where Value == String {
    private func filterInput(allowedCharacters: CharacterSet) -> Self {
        DispatchQueue.main.async {
            wrappedValue = wrappedValue.filter { character in
                character.unicodeScalars.allSatisfy(allowedCharacters.contains)
            }
        }
        return self
    }
    
    var allowOnlyNumbers: Self {
        filterInput(allowedCharacters: .decimalDigits)
    }
    
    var allowOnlyDecimalNumbers: Self {
        var decimalCharacters: CharacterSet = .decimalDigits
        decimalCharacters.insert(charactersIn: ".")
        return filterInput(allowedCharacters: decimalCharacters)
    }
}
