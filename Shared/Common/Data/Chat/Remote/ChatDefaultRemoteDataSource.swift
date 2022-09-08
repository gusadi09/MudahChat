//
//  ChatDefaultRemoteDataSource.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Combine
import Foundation
import Moya

final class ChatDefaultRemoteDataSource: ChatRemoteDataSource {

	private let provider: MoyaProvider<ChatTargetType>

	init(provider: MoyaProvider<ChatTargetType> = .defaultProvider()) {
		self.provider = provider
	}

	func sendMessage(by body: MessageBody) -> AnyPublisher<MessageResponse, ErrorResponse> {
		self.provider.request(.sendMessage(body), model: MessageResponse.self)
	}
}
