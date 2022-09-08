//
//  ChatDefaultRepository.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Combine
import Foundation

final class ChatDefaultRepository: ChatRepository {

	private let local: ChatLocalDataSource
	private let remote: ChatRemoteDataSource

	init(
		local: ChatLocalDataSource = ChatDefaultLocalDataSource(),
		remote: ChatRemoteDataSource = ChatDefaultRemoteDataSource()
	) {
		self.local = local
		self.remote = remote
	}

	func provideSendMessage(by body: MessageBody) -> AnyPublisher<MessageResponse, ErrorResponse> {
		self.remote.sendMessage(by: body)
	}

	func provideSaveChatToLocal(_ chat: Chat) throws {
		try self.local.saveChatToLocal(chat)
	}

	func provideLoadLocalChat() throws -> [Message] {
		try self.local.loadLocalChat()
	}

	func provideDeleteAllChatOnLocal() throws {
		try self.local.deleteAllChat()
	}
}
