//
//  MessageFieldView.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct MessageFieldView: View {
	
	@Binding var message: String
	@Binding var isLoading: Bool
	var action: () -> Void
	
	var body: some View {
		HStack(spacing: 15) {
			MultilineTextField(LocalizationText.generalMessagePlaceholder, text: $message)
				.padding(8)
				.background(
					RoundedRectangle(cornerRadius: 10)
						.foregroundColor(.white)
				)
			
			if isLoading {
				ProgressView()
					.progressViewStyle(.circular)
					.tint(.white)
			} else {
				Button {
					action()
				} label: {
					Image(systemName: "paperplane.fill")
						.resizable()
						.scaledToFit()
						.frame(height: 24)
						.foregroundColor(.white)
				}
			}
		}
		.padding(15)
		.background(
			Rectangle()
				.foregroundColor(.red)
				.edgesIgnoringSafeArea(.bottom)
		)
	}
}

struct MessageFieldView_Previews: PreviewProvider {
	static var previews: some View {
		MessageFieldView(message: .constant(""), isLoading: .constant(false), action: {})
	}
}
