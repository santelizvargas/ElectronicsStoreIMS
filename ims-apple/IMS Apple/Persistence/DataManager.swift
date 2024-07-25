//
//  DataManager.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 22/7/24.
//

import Foundation
import SwiftData

// MARK: - SwiftData Manager

final class DataManager<Model: PersistentModel> {
    
    // MARK: Properties

    private lazy var context: ModelContext = {
        SwiftDataProvider.shared.context
    }()
    
    // MARK: Methods

    func save(model: Model) throws {
        context.insert(model)
    }
    
    func fetch(predicate: Predicate<Model> = .true) throws -> [Model] {
        do {
            let descriptor = FetchDescriptor(predicate: predicate)
            return try context.fetch(descriptor)
        } catch {
            throw DataManagerError.fetchModels
        }
    }
    
    func removeAll() throws {
        do {
            try context.delete(model: Model.self)
        } catch {
            throw DataManagerError.removeModel
        }
    }
    
    func remove(model: Model) {
        context.delete(model)
    }
}
