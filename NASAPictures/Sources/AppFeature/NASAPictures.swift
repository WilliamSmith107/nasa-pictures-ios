//
//  NASAPictures.swift
//  AppFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct NASAPictures {
	@ObservableState
	public struct State: Equatable {
		public init() {}
	}

	public enum Action {
		case initialise
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { _, action in
			switch action {
			case .initialise:
				return .none
			}
		}
	}
}
