//
//  Picture.swift
//  PictureFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import Foundation
import APODClientLive

@Reducer
public struct Picture: Sendable {
	@ObservableState
	public struct State: Equatable {
		public var imageURL: URL?

		public init(
			imageURL: URL? = nil
		) {
			self.imageURL = imageURL
		}
	}

	public enum Action {
		case initialise

		case assignImageURL(String)
	}

	@Dependency(\.apodClient) var apodClient

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .initialise:
				return .run { send in
					let imageURLString = try await apodClient.getAPOD().url
					await send(.assignImageURL(imageURLString))
				}

			case let .assignImageURL(imageURLString):
				state.imageURL = URL(string: imageURLString)
				return .none
			}
		}
	}
}
