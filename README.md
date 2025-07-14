# 🚀 NASA Pictures

A SwiftUI example project built with TCA to fetch NASA's Astronomy Picture of the Day (APOD).

<img src="https://github.com/user-attachments/assets/a36df6d0-fcdd-4e1a-9625-9d3db082a042" height="400"/>

## Overview

Sample project built in TCA demonstrating an API call, testing, state management and dependency management in Swift + SwiftUI for iOS.

Populates a single screen with the APOD, basic error handling for anything that may occur.

App organised as a Swift Package, showcasing highly modular design.

## Usage
- Requires Xcode 16.

- In [APODAPIClient](NASAPictures/Sources/APODClientLive/APODAPIClient.swift) enter either an API key obtained [here](https://api.nasa.gov/) or enter **DEMO_KEY** (rate limited) on line 16.

## Packages

- [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) - Testable state management framework, includes various other [Point-Free]() packages.
- [SnapshotTesting](https://github.com/pointfreeco/swift-composable-architecture) - Snapshot testing for swift.
- [SwiftLintPlugins](https://github.com/SimplyDanny/SwiftLintPlugins) - Swift linting tool to enforce style and conventions.

## API
Atronomy Picture of the Day (APOD):

- [GitHub](https://github.com/nasa/apod-api)
- [Website](https://apod.nasa.gov/apod/astropix.html)
