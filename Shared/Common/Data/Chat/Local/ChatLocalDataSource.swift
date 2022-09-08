//
//  ChatLocalDataSource.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import CoreData

protocol ChatLocalDataSource {
	func saveChatToLocal(_ chat: Chat) throws
	func loadLocalChat() throws -> [Message]
	func deleteAllChat() throws
}
