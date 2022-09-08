//
//  ContentView.swift
//  Shared
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatRoomView: View {

	@ObservedObject var viewModel = ChatRoomViewModel()

	var body: some View {
		GeometryReader { geo in
			VStack(spacing: 0) {
				ChatRoomHeader(geo: geo)
					.alert(isPresented: $viewModel.isError) {
						Alert(
							title: Text(LocalizationText.generalError),
							message: Text(viewModel.error),
							dismissButton: .default(Text("OK"))
						)
					}

				ScrollViewReader { scroll in
					ScrollView(.vertical, showsIndicators: true) {
						LazyVStack {
							ForEach(viewModel.sortedChat(), id: \.id) { data in
								ChatBubble(chat: data)
									.id(data.id)
							}
						}
						.padding(.horizontal, 10)
						.padding(.vertical)
					}
				}

				MessageFieldView(
					message: $viewModel.chatMessage.message,
					isLoading: $viewModel.isLoading
				)
			}
			.onAppear {
				viewModel.loadJSONChat()
			}
		}
	}
}

struct ChatRoomView_Previews: PreviewProvider {
	static var previews: some View {
		ChatRoomView()
	}
}
