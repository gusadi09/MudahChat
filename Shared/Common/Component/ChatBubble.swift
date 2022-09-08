//
//  ChatBubble.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatBubble: View {

	let chat: Chat

	var body: some View {
		HStack {

			if chat.direction == ChatType.outgoing {
				Spacer()
			}

			VStack(alignment: chat.direction == ChatType.outgoing ? .trailing : .leading) {
				Text(chat.message.orEmpty())
					.multilineTextAlignment(chat.direction.orEmpty() == ChatType.outgoing ? .trailing : .leading)
					.padding()
					.background(
						RoundedRectangle(cornerRadius: 12)
							.foregroundColor(chat.direction.orEmpty() == ChatType.outgoing ? .GeneralTheme.primaryRed : .gray.opacity(0.3))
					)

				Text(chat.timestamp.orCurrentDate().toString(format: .HHmm))
					.font(.system(size: 10))
					.opacity(0.5)
			}

			if chat.direction.orEmpty() == ChatType.incoming {
				Spacer()
			}
		}
	}
}

struct ChatBubble_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			ChatBubble(
				chat: Chat(
					timestamp: Date(),
					direction: ChatType.outgoing,
					message: "Heyho whats up bro?"
				)
			)

			ChatBubble(
				chat: Chat(
					timestamp: Date(),
					direction: ChatType.incoming,
					message: "Heyho whats up bro?"
				)
			)
		}
	}
}
