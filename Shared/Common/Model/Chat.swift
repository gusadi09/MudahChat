//
//  Chat.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

public struct ChatResponse: Codable {
	let chat: [Chat]?
}

public struct Chat: Codable {
	let id = UUID()
	let timestamp: Date?
	let direction: String?
	let message: String?
}

public struct MessageBody: Codable {
	let message: String
}

public struct MessageResponse: Codable {
	let id: String?
	let message: String?
	let createdAt: String?

	static func == (lhs: MessageResponse, rhs: MessageResponse) -> Bool {
		return lhs.id.orEmpty() == rhs.id.orEmpty()
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id.orEmpty())
	}
}
