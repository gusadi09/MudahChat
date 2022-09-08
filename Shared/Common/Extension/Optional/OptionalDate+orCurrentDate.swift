//
//  OptionalDate+orCurrentDate.swift
//  DinotisApp
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

extension Optional where Wrapped == Date {
	func orCurrentDate() -> Date {
		return self ?? Date()
	}
}
