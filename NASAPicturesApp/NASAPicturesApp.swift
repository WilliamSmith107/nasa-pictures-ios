//
//  NASAPicturesApp.swift
//  NASAPicturesApp
//
//  Created by William Smith on 09/07/2025.
//

import ComposableArchitecture
import SwiftUI
import AppFeature

@main
struct NASAPicturesApp: App {
    var body: some Scene {
        WindowGroup {
			NASAPicturesView(store: Store(initialState: NASAPictures.State()) {
				NASAPictures()
			})
        }
    }
}
