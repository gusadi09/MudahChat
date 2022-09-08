//
//  ChatTargetType.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import Moya

enum ChatTargetType {
	case sendMessage(MessageBody)
}

extension ChatTargetType: MudahChatTargetType {
	var headers: [String: String]? {
		switch self {
		case .sendMessage:
			return [:]
		}
	}

	var parameterEncoding: Moya.ParameterEncoding {
		switch self {
		case .sendMessage:
			return JSONEncoding.default
		}
	}

	var task: Task {
		return .requestParameters(parameters: parameters, encoding: parameterEncoding)
	}

	var parameters: [String : Any] {
		switch self {
		case .sendMessage(let body):
			return body.toJSON()
		}
	}

	var path: String {
		switch self {
		case .sendMessage:
			return "/users"
		}
	}

	var sampleData: Data {
		switch self {
		case .sendMessage(let body):
			let sampleResponse = MessageResponse(
				id: "123",
				message: body.message,
				createdAt: Date().toString(format: .utcV2)
			)

			return sampleResponse.toJSONData()
		}
	}

	var method:Moya.Method {
		switch self {
		case .sendMessage:
			return .post
		}
	}
}
