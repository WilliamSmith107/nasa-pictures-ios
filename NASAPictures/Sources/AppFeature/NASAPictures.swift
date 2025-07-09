//
//  NASAPictures.swift
//  AppFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import Foundation
import APODClientLive

@Reducer
public struct NASAPictures: Sendable {
	@ObservableState
	public struct State: Equatable {
		public init() {}
	}

	public enum Action {
		case initialise
	}

	@Dependency(\.apodClient) var apodClient

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { _, action in
			switch action {
			case .initialise:
				return .run { _ in
					try await print(apodClient.getAPOD())
				}
			}
		}
	}
}
