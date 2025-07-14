//
//  PictureView.swift
//  PictureFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import SwiftUI
import CommonUI
import Utilities

public struct PictureView: View {
	@State private var imageLoaded: Bool = false

	private let store: StoreOf<Picture>

	public init(store: StoreOf<Picture>) {
		self.store = store
	}

	public var body: some View {
		VStack(spacing: 16) {
			Text("Today's Picture")
				.font(.title)
				.frame(maxWidth: .infinity, alignment: .leading)

			if let response = store.response {
				StoppingPhaseAnimator(ResponseAnimation.allCases, trigger: imageLoaded) { phase in
					imageSection(response: response, phase: phase)
							.padding(.bottom, 16)
					if phase == .detailsAppear {
						detailsSection(response: response)
							.transition(.move(edge: .bottom).combined(with: .opacity))
					}
				} animation: { phase in
					phase.animation
				}
			} else if let error = store.error {
				Text("Error: \(error)")
					.foregroundColor(.red)
					.multilineTextAlignment(.leading)
			}

			Spacer()
		}
		.padding(.horizontal, 24)
		.task {
			store.send(.initialise)
		}
    }

	func detailsSection(response: Picture.State.APODResponse) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(response.title)
				.font(.headline)

			Text(response.date.formattedFromString())
				.font(.caption)

			ScrollView {
				Text(response.explanation)
					.font(.body)
			}
			.scrollIndicators(.hidden)
		}
	}

	func imageSection(response: Picture.State.APODResponse, phase: ResponseAnimation) -> some View {
		AsyncImage(url: response.url) { imagePhase in
			switch imagePhase {
			case .success(let image):
				image
					.resizable()
					.frame(height: 250)
					.cornerRadius(24)
					.overlay {
						if phase == .titleAppear {
							Color.gray
								.overlay(
									Text(response.title)
										.font(.title)
										.foregroundStyle(.white)
								)
								.cornerRadius(24)
						}
					}
					.onAppear {
						if !imageLoaded { imageLoaded = true }
					}
			default:
				RoundedRectangle(cornerRadius: 24)
					.foregroundStyle(.clear)
					.frame(height: 250)
					.shimmer()
			}
		}
		.offset(y: phase == .imageAppear || phase == .titleAppear ? 200 : 0)
	}

	enum ResponseAnimation: CaseIterable {
		case titleAppear
		case imageAppear
		case detailsAppear

		var animation: Animation {
			switch self {
			case .titleAppear:
					.snappy(duration: 0.5)
			case .imageAppear:
					.easeIn(duration: 2.0)
			case .detailsAppear:
					.bouncy(duration: 0.5)
			}
		}
	}
}

#Preview {
	PictureView(store: Store(initialState: Picture.State()) {
		Picture()
	})
}
