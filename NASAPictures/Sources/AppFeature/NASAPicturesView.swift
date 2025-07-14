//
//  NASAPicturesView.swift
//  AppFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import SwiftUI
import PictureFeature

public struct NASAPicturesView: View {
	@State private var splashAnimated = false

	private let store: StoreOf<NASAPictures>

	public init(store: StoreOf<NASAPictures>) {
		self.store = store
	}

	public var body: some View {
		NavigationView {
			switch store.screen {
			case .splashScreen:
				splashView
					.task {
						await runSplashAnimation()
					}
			case .pictureScreen:
				if let store = store.scope(state: \.screen?.pictureScreen, action: \.screen.pictureScreen) {
					PictureView(store: store)
				}
			case .none:
				EmptyView()
			}
		}
    }

	private var splashView: some View {
		Text("Splash")
			.font(.title)
			.scaleEffect(splashAnimated ? 1.5 : 1.0)
	}

	private func runSplashAnimation() async {
		withAnimation(.spring(response: 1.5, dampingFraction: 0.7)) {
			splashAnimated = true
		}

		try? await Task.sleep(nanoseconds: 2_500_000_000)

		store.send(.splashScreenEnded)
	}
}

#Preview {
	NASAPicturesView(store: Store(initialState: NASAPictures.State()) {
		NASAPictures()
	})
}
