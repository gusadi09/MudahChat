//
//  ChatBubble.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatBubble: View {

	@ObservedObject var viewModel = ChatBubbleViewModel()

	let chat: Chat

	var body: some View {
		HStack {

			if viewModel.isOutgoing(chat) {
				Spacer()
			}

			VStack(alignment: viewModel.isOutgoing(chat) ? .trailing : .leading) {
				Text(chat.message.orEmpty())
					.multilineTextAlignment(viewModel.textChatAlignment(chat))
					.padding()
					.background(
						RoundedRectangle(cornerRadius: 12)
							.foregroundColor(viewModel.chatBubbleColor(chat))
					)

				Text(viewModel.formattedTimestamp(chat))
					.font(.system(size: 10))
					.opacity(0.5)
			}

			if viewModel.isIncoming(chat) {
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
