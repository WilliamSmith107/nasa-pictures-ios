//
//  Picture.swift
//  PictureFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import Foundation
import SharedModels
import APODClientLive

@Reducer
public struct Picture: Sendable {
	@ObservableState
	public struct State: Equatable {
		public struct APODResponse: Equatable {
			public let copyright: String?
			public let date: String
			public let explanation: String
			public let title: String
			public let url: URL?

			public init(response: APOD) {
				self.copyright = response.copyright
				self.date = response.date
				self.explanation = response.explanation.replacingOccurrences(
					of: "\\.(\\s*)",
					with: ".\n\n",
					options: .regularExpression
				)
				self.title = response.title
				self.url = URL(string: response.url) ?? nil
			}
		}

		public var response: APODResponse?

		public init(response: APODResponse? = nil) {
			self.response = response
		}
	}

	public enum Action {
		case initialise

		case assignResponse(APOD)
	}

	@Dependency(\.apodClient) var apodClient

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .initialise:
				return .run { send in
					let apodResponse = try await apodClient.getAPOD()
					await send(.assignResponse(apodResponse))
				}

			case let .assignResponse(apodResponse):
				state.response = .init(response: apodResponse)
				return .none
			}
		}
	}
}
