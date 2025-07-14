//
//  PictureFeatureSnapshotTests.swift
//  PictureFeatureTests
//
//  Created by William Smith on 09/07/2025.
//

import Testing
import ComposableArchitecture
import SnapshotTesting
import SwiftUI
@testable import PictureFeature

@MainActor
struct PictureFeatureSnapshotTests {
	let snapshots = [Snapshotting.image(on: .iPhone13Pro), .image(on: .iPhoneSe)]

	@Test func testInitialise_success_snapshot() async throws {
		let responseMock: Picture.State.APODResponse = .init(.mock)

		let testStore = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { .mock }
		}

		await testStore.send(.initialise)

		await testStore.receive(\.assignResponse) {
			$0.response = responseMock
		}

		let liveStore = Store(initialState: testStore.state) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { .mock }
		}

		let pictureView = PictureView(store: liveStore)
		let controller = UIHostingController(rootView: pictureView)

		withSnapshotTesting(record: .missing, diffTool: .default) {
			assertSnapshots(of: controller, as: snapshots)
		}
	}
}
