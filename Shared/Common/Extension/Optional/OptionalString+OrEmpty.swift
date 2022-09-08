//
//  OptionalString+OrEmpty.swift
//  DinotisApp
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

extension Optional where Wrapped == String {
	func orEmpty() -> String {
		return self ?? ""
	}
}
