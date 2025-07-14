//
//  DateUtilities.swift
//  Utilities
//
//  Created by William Smith on 14/07/2025.
//

import Foundation

public extension String {
	func formattedFromString() -> String {
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd"

		guard let date = inputFormatter.date(from: self) else {
			return self
		}

		let day = Calendar.current.component(.day, from: date)
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .ordinal
		let dayWithSuffix = numberFormatter.string(from: NSNumber(value: day)) ?? "\(day)"

		let outputFormatter = DateFormatter()
		outputFormatter.dateFormat = "MMMM yyyy"
		let monthYear = outputFormatter.string(from: date)

		return "\(dayWithSuffix) of \(monthYear)"
	}
}
