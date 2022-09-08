//
//  ChatRoomViewModelTests.swift
//  MudahChatTests
//
//  Created by Gus Adi on 08/09/22.
//

import XCTest
@testable import MudahChat

class ChatRoomViewModelTests: XCTestCase {

    let sut = ChatRoomViewModel()

	func test_loadJsonFile_notEmpty() {
		sut.loadJSONChat()

		XCTAssertFalse(sut.chatArray.isEmpty, "Chat Array is Not Empty")
	}

}
