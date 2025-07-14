//
//  NASAPictures.swift
//  AppFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct NASAPictures: Sendable {
	@ObservableState
	public struct State: Equatable {
		@Presents public var screen: NASAPicturesScreen.State?

		public init(
			screen: NASAPicturesScreen.State = .splashScreen
		) {
			self.screen = screen
		}
	}

	public enum Action {
		case splashScreenEnded

		case screen(PresentationAction<NASAPicturesScreen.Action>)
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .splashScreenEnded:
				state.screen = .pictureScreen(.init())
				return .none

			case .screen:
				return .none
			}
		}
		.ifLet(\.$screen, action: \.screen)
	}
}
