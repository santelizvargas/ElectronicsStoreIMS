//
//  SwiftDataProvider.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 24/7/24.
//

import SwiftData

// MARK: - SwiftData Provider

final class SwiftDataProvider {
    static let shared = SwiftDataProvider()
    
    lazy var container: ModelContainer = {
        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Error creating the model container\nError description: \(error.localizedDescription)")
        }
    }()
    
    lazy var context: ModelContext = {
        ModelContext(container)
    }()
    
    private let schema = Schema([Product.self])
    
    private init() { }
}
