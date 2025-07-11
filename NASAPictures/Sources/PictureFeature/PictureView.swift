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
		AsyncImage(url: store.imageURL)
        Text("PictureView")
			.task {
				store.send(.initialise)
			}
    }
}

#Preview {
	PictureView(store: Store(initialState: Picture.State()) {
		Picture()
	})
}
