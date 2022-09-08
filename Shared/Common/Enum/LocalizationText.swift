//
//  LocalizationText.swift
//  MudahChat
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation

enum LocalizationText {
	static let chatRoomHeaderTitle = NSLocalizedString(
		"chat_room_header_title",
		comment: "this string for title on chat room header"
	)

	static let chatRoomJsonNotFound = NSLocalizedString(
		"chat_room_file_not_found_error",
		comment: "This string for error text if json file not found"
	)

	static let chatRoomFailedToLoadJson = NSLocalizedString(
		"chat_room_failed_to_load",
		comment: "This string for error text if json failed to load"
	)

	static let generalError = NSLocalizedString(
		"general_error",
		comment: "This string is for error title"
	)
}
