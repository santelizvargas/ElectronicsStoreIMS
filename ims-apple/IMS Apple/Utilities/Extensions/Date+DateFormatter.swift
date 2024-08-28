//
//  Date+DateFormatter.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 27/8/24.
//

import Foundation

extension Date {
    var dayMonthYear: String {
        CustomDateFormatter.formatDateToDayMonthYear(from: self)
    }
}
