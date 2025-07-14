//
//  APODAPIClientError.swift
//  APODClientLive
//
//  Created by William Smith on 14/07/2025.
//

import Foundation

public enum APODAPIClientError: LocalizedError {
	case invalidURL
	case jsonDecoding(Error)
	case badResponse(statusCode: Int)
	case network(Error)
	case unknown

	public var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "Invalid URL."
		case .jsonDecoding(let error):
			return "Error decoding JSON: \(error.localizedDescription)"
		case .badResponse(statusCode: let code):
			return "Bad response status code: \(code)"
		case .network(let error):
			return "Network error: \(error.localizedDescription)"
		case .unknown:
			return "Unknown error."
		}
	}
}
