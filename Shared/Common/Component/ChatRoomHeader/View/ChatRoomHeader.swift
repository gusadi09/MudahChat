//
//  ChatRoomHeader.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatRoomHeader: View {

	let geo: GeometryProxy

	@Binding var connection: Bool
	
	var body: some View {
		HStack(spacing: 10) {
			Group {
				if connection {
					Image.GeneralAssets.mudahImage
						.resizable()
						.scaledToFit()
						.frame(
							height: 50
						)
						.clipShape(Circle())

					Text(LocalizationText.chatRoomHeaderTitle)
						.font(
							.system(
								size: 16,
								weight: .semibold
							)
						)
						.foregroundColor(.white)

					Spacer()
				} else {
					Spacer()

					ProgressView()
						.progressViewStyle(.circular)
						.tint(.white)

					Text(LocalizationText.chatRoomHeaderConnecting)
						.foregroundColor(.white)

					Spacer()
				}
			}
		}
		.padding(.horizontal)
		.padding(.vertical, 10)
		.background(
			Rectangle()
				.foregroundColor(.GeneralTheme.primaryRed)
				.edgesIgnoringSafeArea(.top)
		)
	}
}

struct ChatRoomHeader_Previews: PreviewProvider {
    static var previews: some View {
		GeometryReader { geo in
			ChatRoomHeader(geo: geo, connection: .constant(false))
		}
	}
}
