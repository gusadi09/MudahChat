//
//  Date+String.swift
//  DinotisApp
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

extension Date {
	func toString(format: DateFormat) -> String {
		let formatter = DateFormatter()
		formatter.locale = Locale.current
		formatter.dateFormat = format.rawValue
		
		return formatter.string(from: self)
	}
}
