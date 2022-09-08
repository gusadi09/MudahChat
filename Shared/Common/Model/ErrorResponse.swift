//
//  ErrorResponse.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

struct ErrorResponse: Codable, Error {
	let statusCode: Int?
	let error: String?
}
