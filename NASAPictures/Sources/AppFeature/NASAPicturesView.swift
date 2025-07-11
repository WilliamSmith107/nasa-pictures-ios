//
//  NASAPicturesView.swift
//  AppFeature
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import SwiftUI

public struct NASAPicturesView: View {
	private let store: StoreOf<NASAPictures>

	public init(store: StoreOf<NASAPictures>) {
		self.store = store
	}

	public var body: some View {
		AsyncImage(url: store.imageURL)
        Text("NASAPicturesView")
			.task {
				store.send(.initialise)
			}
    }
}

#Preview {
	NASAPicturesView(store: Store(initialState: NASAPictures.State()) {
		NASAPictures()
	})
}
