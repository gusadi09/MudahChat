//
//  ChatBubbleViewModelTests.swift
//  Tests iOS
//
//  Created by Gus Adi on 08/09/22.
//

import XCTest
import SwiftUI
@testable import MudahChat

class ChatBubbleViewModelTests: XCTestCase {

	let sut = ChatBubbleViewModel()
	let dummyChat = Chat(
		timestamp: Date(),
		direction: ChatType.outgoing,
		message: "Heyho"
	)
	let message = Message(context: PersistenceController(inMemory: true).container.viewContext)

	func test_bubbleBackground() {
		message.id = dummyChat.id
		message.timestamp = dummyChat.timestamp
		message.direction = dummyChat.direction
		message.message = dummyChat.message
		XCTAssertEqual(Color.GeneralTheme.primaryRed, sut.chatBubbleColor(message))
	}

	func test_dateStringFormated() {
		message.id = dummyChat.id
		message.timestamp = dummyChat.timestamp
		message.direction = dummyChat.direction
		message.message = dummyChat.message
		XCTAssertEqual(Date().toString(format: .ddMMyyyyHHmm), sut.formattedTimestamp(message))
	}

	func test_textChatAlignment() {
		message.id = dummyChat.id
		message.timestamp = dummyChat.timestamp
		message.direction = dummyChat.direction
		message.message = dummyChat.message
		XCTAssertEqual(TextAlignment.trailing, sut.textChatAlignment(message))
	}

	func test_isOutgoingTrue() {
		message.id = dummyChat.id
		message.timestamp = dummyChat.timestamp
		message.direction = dummyChat.direction
		message.message = dummyChat.message
		XCTAssertTrue(sut.isOutgoing(message))
	}

	func test_isNotIncoming() {
		message.id = dummyChat.id
		message.timestamp = dummyChat.timestamp
		message.direction = dummyChat.direction
		message.message = dummyChat.message
		XCTAssertFalse(sut.isIncoming(message))
	}
}
