//
//  IMS_AppleApp.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 17/7/24.
//

import SwiftUI
import SwiftData

@main
struct IMS_AppleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(SwiftDataProvider.shared.container)
        }
    }
}
