//
//  MessageFieldView.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct MessageFieldView: View {

	@Binding var message: String

    var body: some View {
		HStack {
			MultilineTextField(LocalizationText.generalMessagePlaceholder, text: $message)
				.padding(5)
		}
    }
}

struct MessageFieldView_Previews: PreviewProvider {
    static var previews: some View {
		MessageFieldView(message: .constant(""))
    }
}
