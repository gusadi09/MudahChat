//
//  ChatBubbleViewModel.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import SwiftUI

final class ChatBubbleViewModel: ObservableObject {
	func isOutgoing(_ chat: Chat) -> Bool {
		chat.direction == ChatType.outgoing
	}

	func isIncoming(_ chat: Chat) -> Bool {
		chat.direction == ChatType.incoming
	}

	func textChatAlignment(_ chat: Chat) -> TextAlignment {
		isOutgoing(chat) ? .trailing : .leading
	}

	func chatBubbleColor(_ chat: Chat) -> Color {
		isOutgoing(chat) ? .GeneralTheme.primaryRed : .gray.opacity(0.3)
	}

	func formattedTimestamp(_ chat: Chat) -> String {
		chat.timestamp.orCurrentDate().toString(format: .HHmm)
	}
}
