//
//  Moya+defaultProvider.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import Foundation
import Moya

extension MoyaProvider {
	static func defaultProvider() -> MoyaProvider {
		return MoyaProvider(plugins: [NetworkLoggerPlugin()])
	}
}
