//
//  APODAPIClient.swift
//  APODClientLive
//
//  Created by William Smith on 09/07/2025.
//

import Foundation
import SharedModels

struct APODAPIClient {
	enum APODAPIClientError: Error {
		case invalidURL
		case jsonDecoding(Error)
		case badResponse(statusCode: Int)
		case network(Error)
		case unknown
	}

	private var session: URLSession

	private enum Constants {
		static let path = "https://api.nasa.gov/planetary/apod"
		static let apiKey = "DEMO_KEY"
		static let get = "GET"
	}

	init(session: URLSession = .init(configuration: .default)) {
		self.session = session
	}

	func getAPOD() async throws -> APOD {
		do {
			let request = try self.urlRequest()
			let (data, response) = try await session.data(for: request)

			guard let httpResponse = response as? HTTPURLResponse else {
				throw APODAPIClientError.unknown
			}

			guard (200...299).contains(httpResponse.statusCode) else {
				throw APODAPIClientError.badResponse(statusCode: httpResponse.statusCode)
			}

			do {
				let decodedAPOD = try JSONDecoder().decode(APOD.self, from: data)
				print(decodedAPOD)
				return decodedAPOD
			} catch {
				throw APODAPIClientError.jsonDecoding(error)
			}
		} catch {
			throw APODAPIClientError.network(error)
		}
	}

	private func urlRequest() throws -> URLRequest {
		guard var urlComponents = URLComponents(string: Constants.path) else {
			throw APODAPIClientError.invalidURL
		}

		urlComponents.queryItems = [
			URLQueryItem(name: "api_key", value: Constants.apiKey)
		]

		guard let url = urlComponents.url else {
			throw APODAPIClientError.invalidURL
		}

		var request = URLRequest(url: url)
		request.httpMethod = Constants.get

		return request
	}
}
