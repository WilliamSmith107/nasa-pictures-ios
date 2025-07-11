//
//  AppFeatureTests.swift
//  AppFeatureTests
//
//  Created by William Smith on 09/07/2025.
//

import Testing
import ComposableArchitecture
@testable import AppFeature

@MainActor
struct AppFeatureTests {
	@Test func testInitialise() async throws {
		let store = TestStoreOf<NASAPictures>(initialState: NASAPictures.State()) {
			NASAPictures()
		}

		await store.send(.initialise)
	}
}
