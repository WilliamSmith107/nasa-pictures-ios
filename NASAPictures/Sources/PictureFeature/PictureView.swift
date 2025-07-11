//
//  PictureView.swift
//  PictureFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import SwiftUI

public struct PictureView: View {
	private let store: StoreOf<Picture>

	public init(store: StoreOf<Picture>) {
		self.store = store
	}

	public var body: some View {
		VStack(spacing: 16) {
			if let response = store.response {
				detailsSection(response: response)

				imageSection(response: response)
			}
		}
		.padding(.horizontal, 24)
		.task {
			store.send(.initialise)
		}
    }

	public func detailsSection(response: Picture.State.APODResponse) -> some View {
		VStack(spacing: 8) {
			Text(response.title)

			Text(response.explanation)

			Text(response.date)
		}
	}

	public func imageSection(response: Picture.State.APODResponse) -> some View {
		VStack(alignment: .center, spacing: 8) {
			AsyncImage(url: response.url) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
			} placeholder: {
				ProgressView()
			}
			.frame(maxWidth: .infinity)

			Text(response.copyright ?? "")
		}
	}
}

#Preview {
	PictureView(store: Store(initialState: Picture.State()) {
		Picture()
	})
}
