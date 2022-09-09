//
//  ChatDefaultLocalDataSource.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import CoreData

final class ChatDefaultLocalDataSource: ChatLocalDataSource {

	private let container: NSPersistentContainer

	init(container: NSPersistentContainer = PersistenceController.shared.container) {
		self.container = container
	}

	func saveChatToLocal(_ chat: Chat) throws {
		let entity = Message(context: container.viewContext)

		entity.id = chat.id
		entity.direction = chat.direction
		entity.timestamp = chat.timestamp
		entity.message = chat.message

		if container.viewContext.hasChanges {
			try container.viewContext.save()
		}
	}

	func loadLocalChat() throws -> [Message] {
		let fetchReq = try container.viewContext.fetch(Message.fetchRequest())

		return fetchReq
	}

	func deleteAllChat() throws {
		let item = try loadLocalChat()

		for item in item {
			container.viewContext.delete(item)
		}

		if container.viewContext.hasChanges {
			try container.viewContext.save()
		}
	}
}
