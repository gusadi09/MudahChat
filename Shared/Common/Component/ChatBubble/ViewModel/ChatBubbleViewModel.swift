//
//  ChatBubbleViewModel.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import SwiftUI

final class ChatBubbleViewModel: ObservableObject {
	func isOutgoing(_ chat: Message) -> Bool {
		chat.direction == ChatType.outgoing
	}
	
	func isIncoming(_ chat: Message) -> Bool {
		chat.direction == ChatType.incoming
	}
	
	func textChatAlignment(_ chat: Message) -> TextAlignment {
		isOutgoing(chat) ? .trailing : .leading
	}
	
	func chatBubbleColor(_ chat: Message) -> Color {
		isOutgoing(chat) ? .GeneralTheme.primaryRed : .gray.opacity(0.3)
	}
	
	func formattedTimestamp(_ chat: Message) -> String {
		chat.timestamp.orCurrentDate().toString(format: .ddMMyyyyHHmm)
	}
}
