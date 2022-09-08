//
//  ChatRepository.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Combine
import Foundation

protocol ChatRepository {
	func provideSendMessage(by body: MessageBody) -> AnyPublisher<MessageResponse, ErrorResponse>
	func provideSaveChatToLocal(_ chat: Chat) throws
	func provideLoadLocalChat() throws -> [Message]
	func provideDeleteAllChatOnLocal() throws
}
