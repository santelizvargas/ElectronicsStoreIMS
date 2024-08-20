//
//  OnkeyboardAppear.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 19/8/24.
//

import SwiftUI

struct OnkeyboardAppear: ViewModifier {
    @State private var isKeyboardVisible: Bool = false
    
    func body(content: Content) -> some View {
        ScrollView(showsIndicators: false) {
            content
                .onAppear {
                    #if os(iOS)
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardWillShowNotification,
                        object: nil,
                        queue: .main) { _ in
                            isKeyboardVisible = true
                        }
                    
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardWillHideNotification,
                        object: nil,
                        queue: .main) { _ in
                            isKeyboardVisible = false
                        }
                    #endif
                }
        }
        .scrollDisabled(!isKeyboardVisible)
    }
}
