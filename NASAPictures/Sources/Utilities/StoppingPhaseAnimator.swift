//
//  StoppingPhaseAnimator.swift
//  Utilities
//
//  Created by William Smith on 14/07/2025.
//

import SwiftUI

public struct StoppingPhaseAnimator<Phase, Content, Trigger>: View where Phase: Equatable, Content: View, Trigger: Equatable {
	let phases: [Phase]
	let trigger: Trigger
	let content: (Phase) -> Content
	let animation: (Phase) -> Animation?

	@State var lastTrigger: Trigger?

	public init(
		_ phases: [Phase],
		trigger: Trigger,
		@ViewBuilder content: @escaping (Phase) -> Content,
		animation: @escaping (Phase) -> Animation? = { _ in .default }
	) {
		assert(phases.count >= 1)
		self.phases = phases
		self.trigger = trigger
		self.content = content
		self.animation = animation
	}

	func stoppingContent(phase: Phase) -> Content {
		var stoppingPhase = phase

		if phase == phases[0] {
			if let lastTrigger, trigger == lastTrigger {
				stoppingPhase = phases.last!
			} else {
				stoppingPhase = phase
			}
		} else {
			DispatchQueue.main.async {
				lastTrigger = trigger
			}
		}

		return content(stoppingPhase)
	}

	public var body: some View {
		PhaseAnimator(phases, trigger: trigger, content: stoppingContent, animation: animation)
	}
}
