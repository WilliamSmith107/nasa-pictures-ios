//
//  APODMock.swift
//  SharedModels
//
//  Created by William Smith on 11/07/2025.
//

import Foundation

public extension APOD {
	static var mock: Self {
		return .init(
			copyright: nil,
			date: "2025-07-11",
			explanation: "Transfusing sunlight as the sky grew darker, this exceptional display of noctilucent clouds was captured on July 10, reflected in the calm waters of Vallentuna Lake near Stockholm, Sweden. From the edge of space, about 80 kilometers above Earth\'s surface, the icy clouds themselves still reflect sunlight, even though the Sun is below the horizon as seen from the ground. Usually spotted at high latitudes in summer months, the night shining clouds have made a strong showing so far during the short northern summer nights. Also known as polar mesopheric clouds they are understood to form as water vapor driven into the cold upper atmosphere condenses on the fine dust particles supplied by disintegrating meteors or volcanic ash.",
			hdurl: "https://apod.nasa.gov/apod/image/2507/NLCreflectionsHeden.jpg",
			mediaType: "image",
			serviceVersion: "v1",
			title: "The Veins of Heaven",
			url: "https://apod.nasa.gov/apod/image/2507/NLCreflectionsHeden.jpg"
		)
	}

	static var mockCopyright: Self {
		return .init(
			copyright: "Clear Skies",
			date: "2025-07-11",
			explanation: "Transfusing sunlight as the sky grew darker, this exceptional display of noctilucent clouds was captured on July 10, reflected in the calm waters of Vallentuna Lake near Stockholm, Sweden. From the edge of space, about 80 kilometers above Earth\'s surface, the icy clouds themselves still reflect sunlight, even though the Sun is below the horizon as seen from the ground. Usually spotted at high latitudes in summer months, the night shining clouds have made a strong showing so far during the short northern summer nights. Also known as polar mesopheric clouds they are understood to form as water vapor driven into the cold upper atmosphere condenses on the fine dust particles supplied by disintegrating meteors or volcanic ash.",
			hdurl: "https://apod.nasa.gov/apod/image/2507/NLCreflectionsHeden.jpg",
			mediaType: "image",
			serviceVersion: "v1",
			title: "The Veins of Heaven",
			url: "https://apod.nasa.gov/apod/image/2507/NLCreflectionsHeden.jpg"
		)
	}
}
