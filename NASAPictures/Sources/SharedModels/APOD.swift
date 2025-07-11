//
//  APOD.swift
//  SharedModels
//
//  Created by William Smith on 09/07/2025.
//

import Foundation

public struct APOD: Decodable {
	public let copyright: String?
	public let date: String
	public let explanation: String
	public let hdurl: String
	public let mediaType: String
	public let serviceVersion: String
	public let title: String
	public let url: String

	enum CodingKeys: String, CodingKey {
		case copyright = "copyright"
		case date
		case explanation
		case hdurl
		case mediaType = "media_type"
		case serviceVersion = "service_version"
		case title
		case url
	}

	public init(
		copyright: String? = nil,
		date: String,
		explanation: String,
		hdurl: String,
		mediaType: String,
		serviceVersion: String,
		title: String,
		url: String
	) {
		self.copyright = copyright
		self.date = date
		self.explanation = explanation
		self.hdurl = hdurl
		self.mediaType = mediaType
		self.serviceVersion = serviceVersion
		self.title = title
		self.url = url
	}
}
