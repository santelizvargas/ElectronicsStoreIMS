//
//  IMS_AppleApp.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 17/7/24.
//

import SwiftUI
import SwiftData

@main
struct IMS_AppleApp: App {
    @State private var navigationPath: NavigationPath = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                LoginView(navigationPath: $navigationPath)
                    .preferredColorScheme(.dark)
                    .modelContainer(SwiftDataProvider.shared.container)
                    .navigationDestination(for: Bool.self) { _ in
                        MainView(navigationPath: $navigationPath)
                    }
            }
        }
    }
}
