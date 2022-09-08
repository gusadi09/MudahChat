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

	func test_bubbleBackground() {
		XCTAssertEqual(Color.GeneralTheme.primaryRed, sut.chatBubbleColor(dummyChat))
	}

	func test_dateStringFormated() {
		XCTAssertEqual(Date().toString(format: .ddMMyyyyHHmm), sut.formattedTimestamp(dummyChat))
	}

	func test_textChatAlignment() {
		XCTAssertEqual(TextAlignment.trailing, sut.textChatAlignment(dummyChat))
	}

	func test_isOutgoingTrue() {
		XCTAssertTrue(sut.isOutgoing(dummyChat))
	}

	func test_isNotIncoming() {
		XCTAssertFalse(sut.isIncoming(dummyChat))
	}
}
