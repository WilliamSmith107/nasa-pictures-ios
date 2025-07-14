//
//  PictureFeatureTests.swift
//  PictureFeatureTests
//
//  Created by William Smith on 09/07/2025.
//

import Testing
import ComposableArchitecture
import Foundation
@testable import PictureFeature
@testable import APODClientLive

@MainActor
struct PictureFeatureTests {
	@Test func testInitialise_assignAPOD_success() async throws {
		let responseMock: Picture.State.APODResponse = .init(.mock)

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { .mock }
		}

		await store.send(.initialise)

		await store.receive(\.assignResponse) {
			$0.response = responseMock
		}
	}

	@Test func testInitialise_assignAPODCopyright_success() async throws {
		let responseMock: Picture.State.APODResponse = .init(.mockCopyright)

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { .mockCopyright }
		}

		await store.send(.initialise)

		await store.receive(\.assignResponse) {
			$0.response = responseMock
		}
	}

	@Test func testInitialise_invalidURL_failure() async throws {
		let expectedError = "Invalid URL."

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { throw APODAPIClientError.invalidURL }
		}

		await store.send(.initialise)

		await store.receive(\.assignError) {
			$0.error = expectedError
		}
	}

	@Test func testInitialise_jsonDecoding_failure() async throws {
		let expectedError = "Error decoding JSON: Failed to decode."

		let localizedError = "Failed to decode."
		let decodingError = NSError(domain: "test", code: 123, userInfo: [NSLocalizedDescriptionKey: localizedError])

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { throw APODAPIClientError.jsonDecoding(decodingError) }
		}

		await store.send(.initialise)

		await store.receive(\.assignError) {
			$0.error = expectedError
		}
	}

	@Test func testInitialise_badResponse_failure() async throws {
		let expectedError = "Bad response status code: 401"

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { throw APODAPIClientError.badResponse(statusCode: 401) }
		}

		await store.send(.initialise)

		await store.receive(\.assignError) {
			$0.error = expectedError
		}
	}

	@Test func testInitialise_network_failure() async throws {
		let expectedError = "Network error: No internet connection."

		let localizedError = "No internet connection."
		let networkError = NSError(domain: "test", code: 123, userInfo: [NSLocalizedDescriptionKey: localizedError])

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { throw APODAPIClientError.network(networkError) }
		}

		await store.send(.initialise)

		await store.receive(\.assignError) {
			$0.error = expectedError
		}
	}

	@Test func testInitialise_unknown_failure() async throws {
		let expectedError = "Unknown error."

		let store = TestStoreOf<Picture>(initialState: Picture.State()) {
			Picture()
		} withDependencies: {
			$0.apodClient.getAPOD = { throw APODAPIClientError.unknown }
		}

		await store.send(.initialise)

		await store.receive(\.assignError) {
			$0.error = expectedError
		}
	}
}
