//
//  String+DateFormatter.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 20/8/24.
//

import Foundation

extension String {
    var dayMonthYear: String {
        CustomDateFormatter.formatDateToDayMonthYear(self, format: .iso8601)
    }
}
