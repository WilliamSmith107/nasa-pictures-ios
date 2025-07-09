//
//  APODClientLive.swift
//  APODClientLive
//
//  Created by William Smith on 09/07/2025.
//

import Dependencies
import DependenciesMacros
import APODClient

extension APODClient: DependencyKey {
	static public var liveValue: Self {
		return Self(
			getAPOD: {
				do {
					return try await APODAPIClient().getAPOD()
				} catch {
					// TODO: Banner presenter of some description.
					throw error
				}
			}
		)
	}
}
