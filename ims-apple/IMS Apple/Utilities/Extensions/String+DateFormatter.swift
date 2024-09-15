//
//  String+DateFormatter.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import Foundation

extension String {
    var dayMonthYear: String {
        CustomDateFormatter.formatDateToDayMonthYear(self, format: .iso8601)
    }
    
    var yearMonthDay: String {
        CustomDateFormatter.formatDateToYearMonthDay(from: self)
    }
    
    var yearMonthDayHoursMinutes: String {
        CustomDateFormatter.formatDateToYearMonthDayHoursMinutes(self, format: .simpleFormat)
    }
}
