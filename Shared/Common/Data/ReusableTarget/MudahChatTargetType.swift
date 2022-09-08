//
//  MudahChatTargetType.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import Moya

protocol MudahChatTargetType: TargetType {
	var parameters: [String: Any] {
		get
	}
}

extension MudahChatTargetType {
	var baseURL: URL {
		return URL(string: "https://reqres.in/api") ?? (NSURL() as URL)
	}

	var parameterEncoding: Moya.ParameterEncoding {
		JSONEncoding.default
	}

	var task: Task {
		return .requestParameters(parameters: parameters, encoding: parameterEncoding)
	}

	var headers: [String: String]? {
		return [:]
	}
}
