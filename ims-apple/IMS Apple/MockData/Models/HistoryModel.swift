//
//  HistoryModel.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 5/8/24.
//

import Foundation

struct HistoryModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let phoneNumber: String
    let date: String
}

// MARK: - Mock Data
extension HistoryModel {
    static let mockData: [HistoryModel] = [
        HistoryModel(name: "John Doe", phoneNumber: "123-456-7890", date: "2024-01-01"),
        HistoryModel(name: "Jane Smith", phoneNumber: "098-765-4321", date: "2024-02-02"),
        HistoryModel(name: "Alice Johnson", phoneNumber: "555-123-4567", date: "2024-03-03"),
        HistoryModel(name: "Bob Brown", phoneNumber: "444-987-6543", date: "2024-04-04"),
        HistoryModel(name: "Charlie Davis", phoneNumber: "333-654-9876", date: "2024-05-05")
    ]
}
