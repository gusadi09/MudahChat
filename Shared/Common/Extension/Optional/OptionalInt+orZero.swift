//
//  OptionalInt+orZero.swift
//  DinotisApp
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

extension Optional where Wrapped == Int {
	func orZero() -> Int {
		return self ?? 0
	}
}
