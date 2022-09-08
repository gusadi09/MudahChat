//
//  ChatStubRepository.swift
//  MudahChatTests
//
//  Created by Gus Adi on 09/09/22.
//

import Combine
import Foundation
import Moya

final class ChatStubRepository: ChatRepository {

	private let local: ChatLocalDataSource
	private let remote: ChatRemoteDataSource
	private let endpointClosureError = { (target: ChatTargetType) -> Endpoint in
		return Endpoint(
			url: URL(target: target).absoluteString,
			sampleResponseClosure: {
				.networkResponse(
					404,
					ErrorResponse(statusCode: 404, error: "Error Not Found").toJSONData()
				)
			},
			method: target.method,
			task: target.task,
			httpHeaderFields: target.headers
		)
	}

	init(
		local: ChatLocalDataSource = ChatDefaultLocalDataSource(container: PersistenceController(inMemory: true).container),
		remote: ChatRemoteDataSource = ChatDefaultRemoteDataSource(provider: MoyaProvider<ChatTargetType>(stubClosure: MoyaProvider.delayedStub(1.0), plugins: [NetworkLoggerPlugin()])),
		isErrorRemote: Bool
	) {
		self.local = local
		self.remote = isErrorRemote ? ChatDefaultRemoteDataSource(provider: MoyaProvider<ChatTargetType>(endpointClosure: endpointClosureError, stubClosure: MoyaProvider.delayedStub(1.0))) : remote
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


