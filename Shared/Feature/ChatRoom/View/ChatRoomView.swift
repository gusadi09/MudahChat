//
//  ContentView.swift
//  Shared
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

struct ChatRoomView: View {

	var body: some View {
		GeometryReader { geo in
			VStack {
				ChatRoomHeader(geo: geo)
			}
		}
	}
}

struct ChatRoomView_Previews: PreviewProvider {
	static var previews: some View {
		ChatRoomView()
	}
}
