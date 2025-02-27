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
        case yearMonthDay = "yyyy-MM-dd"
        case yearMonthDayHoursMinutes = "EEEE, yyyy MMM dd, HH:mm a"
        case simpleFormat = "yyyy-M-d-H-m"
    }
    
    static func formatDateToDayMonthYear(_ dateString: String, format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = DateFormat.dayMonthYear.rawValue
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.string(from: date)
    }
    
    static func formatDateToYearMonthDayHoursMinutes(_ dateString: String, format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = DateFormat.yearMonthDayHoursMinutes.rawValue
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.string(from: date)
    }
    
    static func formatDateToDayMonthYear(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dayMonthYear.rawValue
        dateFormatter.locale = Locale(identifier: "es_ES")
        return dateFormatter.string(from: date)
    }
    
    static func formatDateToYearMonthDay(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.iso8601.rawValue
        
        guard let date = dateFormatter.date(from: date) else { return "" }
        dateFormatter.dateFormat = DateFormat.yearMonthDay.rawValue
        return dateFormatter.string(from: date)
    }
}
