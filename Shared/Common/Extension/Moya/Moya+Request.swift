//
//  Moya+Request.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Combine
import CombineMoya
import Foundation
import Moya

extension MoyaProvider {
	func request<T: Codable>(_ target: Target, model: T.Type) -> AnyPublisher<T, ErrorResponse> {
		self.requestPublisher(target)
			.mapError { moyaError in
				ErrorResponse(statusCode: moyaError.errorCode, error: moyaError.errorDescription)
			}
			.flatMap { (response) -> AnyPublisher<T, ErrorResponse> in
				let errorCode = response.statusCode
				let jsonDecoder = JSONDecoder()
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = DateFormat.utcV2.rawValue
				jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

				do {
					if errorCode == 200 {
						let model = try jsonDecoder.decode(model.self, from: response.data)
						return Just(model).setFailureType(to: ErrorResponse.self).eraseToAnyPublisher()
					} else {
						let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: response.data)
						return Fail(error: errorResponse).eraseToAnyPublisher()
					}
				} catch {
					let error = ErrorResponse(statusCode: -1, error: error.localizedDescription)
					return Fail(error: error).eraseToAnyPublisher()
				}
			}
			.eraseToAnyPublisher()
	}
}
