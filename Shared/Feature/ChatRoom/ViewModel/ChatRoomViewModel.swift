//
//  ChatRoomViewModel.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

final class ChatRoomViewModel: ObservableObject {

	@Published var isLoading = false
	@Published var isError = false
	@Published var error = ""
	@Published var chatArray = [Chat]()

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

	func sortedChat() -> [Chat] {
		chatArray.sorted(by: { $0.timestamp.orCurrentDate() < $1.timestamp.orCurrentDate() })
	}
}
