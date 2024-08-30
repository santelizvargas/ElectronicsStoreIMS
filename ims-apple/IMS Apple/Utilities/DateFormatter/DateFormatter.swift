//
//  DateFormatter.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import SwiftUI

final class CustomDateFormatter {
    enum DateFormat: String {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case dayMonthYear = "dd MMM yyyy"
    }
    
    static func formatDateToDayMonthYear(_ dateString: String, format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = DateFormat.dayMonthYear.rawValue
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.string(from: date)
    }
    
    static func formatDateToDayMonthYear(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dayMonthYear.rawValue
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.string(from: date)
    }
}
