//
//  ChatRoomViewModel.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import Combine
import Foundation
import Network

final class ChatRoomViewModel: ObservableObject {
	
	private let chatRepository: ChatRepository
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue(label: "NetworkMonitor")
	private var cancellables = Set<AnyCancellable>()
	private var timer: Timer?

	@Published var isNotActiveLastMinute = false
	@Published var isLoading = false
	@Published var isError = false
	@Published var error = ""
	@Published var chatArray = [Chat]()
	@Published var localChatHistory = [Message]()
	@Published var chatMessage = MessageBody(message: "")
	@Published var isConnected = false
	
	init(chatRepository: ChatRepository = ChatDefaultRepository()) {
		self.chatRepository = chatRepository

		monitor.pathUpdateHandler = { [weak self] path in
			DispatchQueue.main.async {
				self?.isConnected = path.status == .satisfied ? true : false
			}
		}

		monitor.start(queue: queue)
	}
	
	func loadJSONChat() {
		isError = false
		error = ""
		let decoder = JSONDecoder()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormat.utcV2.rawValue
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		
		guard let url = Bundle.main.url(forResource: "PreloadChat", withExtension: "json") else {
			self.isError = true
			self.error = LocalizationText.chatRoomJsonNotFound
			return
		}
		
		do {
			let data = try Data(contentsOf: url)
			let object = try decoder.decode(ChatResponse.self, from: data)
			chatArray = object.chat ?? []
		} catch {
			print(error)
			self.isError = true
			self.error = LocalizationText.chatRoomFailedToLoadJson
		}
	}
	
	func sortedChat() -> [Message] {
		localChatHistory.sorted(by: { $0.timestamp.orCurrentDate() < $1.timestamp.orCurrentDate() })
	}
	
	func startRequest() {
		self.isLoading = true
		self.isError = false
		self.error = ""
	}
	
	func sendMessage() {
		startRequest()
		
		chatRepository.provideSendMessage(by: chatMessage)
			.sink { result in
				switch result {
				case .failure(let error):
					self.isError = true
					self.isLoading = false
					self.error = error.error.orEmpty()
					
				case .finished:
					self.isLoading = false
					self.isNotActiveLastMinute = false
					self.checkingInactive()
				}
			} receiveValue: { response in
				let chat = Chat(
					timestamp: response.createdAt,
					direction: ChatType.outgoing,
					message: response.message
				)
				
				self.chatArray.append(chat)
				self.saveToLocalChat(chat)
				self.chatMessage.message = ""
				self.loadLocalChat()
			}
			.store(in: &cancellables)
		
	}
	
	func saveToLocalChat(_ chat: Chat) {
		isError = false
		error = ""
		
		do {
			try self.chatRepository.provideSaveChatToLocal(chat)
		} catch {
			self.isError = true
			self.isLoading = false
			self.error = error.localizedDescription
		}
	}
	
	func loadLocalChat() {
		isError = false
		error = ""
		
		do {
			self.localChatHistory = try self.chatRepository.provideLoadLocalChat()
		} catch {
			self.isError = true
			self.isLoading = false
			self.error = error.localizedDescription
		}
	}
	
	func deleteAllChat() {
		isError = false
		error = ""
		
		do {
			try self.chatRepository.provideDeleteAllChatOnLocal()
		} catch {
			self.isError = true
			self.isLoading = false
			self.error = error.localizedDescription
		}
	}
	
	func onChatRoomAppear() {
		loadLocalChat()
		
		if localChatHistory.isEmpty {
			loadJSONChat()
			
			for item in chatArray {
				saveToLocalChat(item)
			}
			
			loadLocalChat()
		}

		checkingInactive()
	}

	func checkingInactive() {
		if let timer = timer {
			timer.invalidate()
		}

		let getting = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(sendNotActiveMessage), userInfo: nil, repeats: true)

		self.timer = getting
	}

	@objc func sendNotActiveMessage() {
		if !isNotActiveLastMinute {
			let chat = Chat(
				timestamp: Date(),
				direction: ChatType.incoming,
				message: LocalizationText.chatRoomNotActiveMessage
			)

			chatArray.append(chat)

			saveToLocalChat(chat)

			loadLocalChat()

			isNotActiveLastMinute = true

			if let timer = timer {
				timer.invalidate()
			}
		}
	}
}
