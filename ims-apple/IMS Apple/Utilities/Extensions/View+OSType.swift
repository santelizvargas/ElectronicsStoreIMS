//
//  View+OSType.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/8/24.
//

import SwiftUI

// MARK: - Operating System

enum OSType {
    case macOS
    case iOS
    
    static let current: Self = {
        #if os(macOS)
        macOS
        #elseif os(iOS)
        iOS
        #else
        #error("Unsuported platform")
        #endif
    }()
}

// MARK: - Apply modifier

extension View {
    @ViewBuilder
    func isOS<Content: View>(
        _ operatingSystems: OSType...,
        modifier: (Self) -> Content
    ) -> some View {
        if operatingSystems.contains(OSType.current) {
            modifier(self)
        } else {
            self
        }
    }
}
