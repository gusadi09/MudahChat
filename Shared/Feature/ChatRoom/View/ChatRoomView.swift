//
//  ContentView.swift
//  Shared
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatRoomView: View {

	@FocusState var focused: Bool
	@ObservedObject var viewModel = ChatRoomViewModel()

	var body: some View {
		GeometryReader { geo in
			VStack(spacing: 0) {
				ChatRoomHeader(geo: geo, connection: $viewModel.isConnected)
					.alert(isPresented: $viewModel.isError) {
						Alert(
							title: Text(LocalizationText.generalError),
							message: Text(viewModel.error),
							dismissButton: .default(Text("OK"))
						)
					}
					.onTapGesture {
						focused = false
					}

				ScrollViewReader { scroll in
					VStack(spacing: 0) {
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
						.onChange(of: viewModel.sortedChat().last) { newValue in
							withAnimation {
								scroll.scrollTo(newValue?.id ?? UUID(), anchor: .bottom)
							}
						}
						.onTapGesture {
							focused = false
						}

						MessageFieldView(
							focused: _focused,
							message: $viewModel.chatMessage.message,
							isLoading: $viewModel.isLoading
						) {
							if viewModel.isConnected {
								viewModel.sendMessage()
							}
						}
					}
				}
				
			}
			.onAppear {
				viewModel.onChatRoomAppear()
			}
		}
	}
}

struct ChatRoomView_Previews: PreviewProvider {
	static var previews: some View {
		ChatRoomView()
	}
}
