//
//  OptionalDouble+OrZero.swift
//  DinotisApp
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

extension Optional where Wrapped == Double {
	func orZero() -> Double {
		return self ?? 0.0
	}
}
