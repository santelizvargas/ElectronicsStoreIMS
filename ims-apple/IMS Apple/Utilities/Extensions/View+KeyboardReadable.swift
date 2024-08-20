//
//  View+KeyboardReadable.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 19/8/24.
//

import SwiftUI

extension View {
    func onKeyboardAppear() -> some View {
        #if os(iOS)
        modifier(OnkeyboardAppear())
        #else
        self
        #endif
    }
}
