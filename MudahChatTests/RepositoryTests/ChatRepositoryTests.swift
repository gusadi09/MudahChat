//
//  ChatRepositoryTests.swift
//  MudahChatTests
//
//  Created by Gus Adi on 09/09/22.
//

import XCTest
import Combine
@testable import MudahChat

class ChatRepositoryTests: XCTestCase {

	private let sut = ChatStubRepository(isErrorRemote: false)
	private let errorSut = ChatStubRepository(isErrorRemote: true)
	private var cancellables = Set<AnyCancellable>()

	let dummyBody = MessageBody(message: "Hello Unit Test")

	func test_sendMessage_sended() throws {
		let expectation = XCTestExpectation(description: "sendMessage")

		sut.provideSendMessage(by: dummyBody)
			.sink { result in
				switch result {
				case .failure(let error):
					XCTFail(error.error.orEmpty())

				case .finished:
					break
				}
			} receiveValue: { value in
				XCTAssertEqual(value.message, self.dummyBody.message)
				expectation.fulfill()
			}
			.store(in: &cancellables)
	}

	func test_sendMessage_error() throws {
		let expectation = XCTestExpectation(description: "sendMessageError")

		errorSut.provideSendMessage(by: dummyBody)
			.sink { result in
				switch result {
				case .failure(let error):
					XCTAssertEqual(error.statusCode.orZero(), 404)
					expectation.fulfill()
				case .finished:
					break
				}
			} receiveValue: { _ in
				XCTFail("Not expected result")
			}
			.store(in: &cancellables)
	}

	func test_saveLocal_success() throws {
		let expectation = XCTestExpectation(description: "saveLocal")
		let chat = Chat(timestamp: Date(), direction: ChatType.outgoing, message: "Hello Unit Tests")

		do {
			try sut.provideDeleteAllChatOnLocal()

			try sut.provideSaveChatToLocal(chat)

			let message = try sut.provideLoadLocalChat()

			XCTAssertFalse(message.isEmpty)
			expectation.fulfill()
		} catch {
			XCTFail(error.localizedDescription)
		}
	}

	func test_loadLocal_empty() throws {
		let expectation = XCTestExpectation(description: "loadLocal")

		do {

			let message = try sut.provideLoadLocalChat()
			XCTAssertTrue(message.isEmpty)
			expectation.fulfill()
		} catch {
			XCTFail(error.localizedDescription)
		}
	}

	func test_deleteAllChat() throws {
		let expectation = XCTestExpectation(description: "deleteAllLocal")

		do {
			try sut.provideDeleteAllChatOnLocal()

			let message = try sut.provideLoadLocalChat()

			XCTAssertTrue(message.isEmpty)
			expectation.fulfill()
		} catch {
			XCTFail(error.localizedDescription)
		}
	}
}
