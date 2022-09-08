//
//  ChatRemoteDataSource.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Combine
import Foundation

protocol ChatRemoteDataSource {
	func sendMessage(by body: MessageBody) -> AnyPublisher<MessageResponse, ErrorResponse>
}
