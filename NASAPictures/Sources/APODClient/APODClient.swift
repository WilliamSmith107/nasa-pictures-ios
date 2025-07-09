//
//  APODClient.swift
//  APODClient
//
//  Created by William Smith on 09/07/2025.
//

import Dependencies
import DependenciesMacros
import SharedModels

@DependencyClient
public struct APODClient: Sendable {
	public var getAPOD: @Sendable () async throws -> APOD
}

extension APODClient: TestDependencyKey {
	public static var testValue: Self {
		return Self()
	}
}

extension DependencyValues {
	public var apodClient: APODClient {
		get { self[APODClient.self] }
		set { self[APODClient.self] = newValue }
	}
}
