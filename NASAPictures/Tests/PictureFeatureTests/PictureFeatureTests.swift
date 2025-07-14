//
//  PictureFeatureTests.swift
//  PictureFeatureTests
//
//  Created by William Smith on 09/07/2025.
//

import Testing
import ComposableArchitecture
@testable import PictureFeature

@MainActor
struct PictureFeatureTests {
	@Test func testInitialise() async throws {
		_ = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		}
	}
}
