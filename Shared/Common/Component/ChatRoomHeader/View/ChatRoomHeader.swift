//
//  ChatRoomHeader.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatRoomHeader: View {

	let geo: GeometryProxy
	
	var body: some View {
		HStack {
			Image.GeneralAssets.mudahImage
				.resizable()
				.scaledToFit()
				.frame(
					height: geo.size.height/15
				)
				.clipShape(Circle())

			Text(LocalizationText.chatRoomHeaderTitle)
				.font(
					.system(
						size: geo.size.height/45,
						weight: .semibold
					)
				)
				.foregroundColor(.white)

			Spacer()
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
			ChatRoomHeader(geo: geo)
		}
	}
}
