//
//  ChatBubble.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatBubble: View {
	
	@ObservedObject var viewModel = ChatBubbleViewModel()
	
	let chat: Message
	
	var body: some View {
		HStack {
			
			if viewModel.isOutgoing(chat) {
				Spacer()
			}
			
			VStack(alignment: viewModel.isOutgoing(chat) ? .trailing : .leading) {
				Text(chat.message.orEmpty())
					.font(.system(size: 12))
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
