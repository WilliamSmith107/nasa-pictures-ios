//
//  ShimmerModifier.swift
//  CommonUI
//
//  Created by William Smith on 13/07/2025.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
	private let gradientColors: [Color] = [
		.gray.opacity(1),
		.gray.opacity(0.6),
		.gray.opacity(1)
	]

	@State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
	@State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)

	func body(content: Content) -> some View {
		content
			.overlay {
				LinearGradient(
					colors: gradientColors,
					startPoint: startPoint,
					endPoint: endPoint
				)
			}
			.cornerRadius(24)
			.onAppear {
				withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false)) {
					startPoint = .init(x: 1.0, y: 1.0)
					endPoint = .init(x: 2.2, y: 2.2)
				}
			}
	}
}

public extension View {
	func shimmer() -> some View {
		modifier(ShimmerModifier())
	}
}
