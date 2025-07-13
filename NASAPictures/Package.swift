// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NASAPictures",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v18),
		.macOS(.v15)
	],
    products: [
        .library("AppFeature"),
        .library("APODClient"),
        .library("APODClientLive"),
        .library("CommonUI"),
        .library("PictureFeature"),
        .library("SharedModels"),
    ],
	dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.20.2"),
		.package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.59.1"),
//		.package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.18.4"),
	],
    targets: [
		// AppFeature
        .target(
            name: "AppFeature",
			dependencies: [
				.composableArchitecture,
			]
		),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),

		// APODClient
		.target(
            name: "APODClient",
			dependencies: [
				.composableArchitecture,
				.sharedModels,
			]
		),

		// APODClientLive
		.target(
			name: "APODClientLive",
			dependencies: [
				.composableArchitecture,
				.sharedModels,
				.apodClient,
			]
		),

		// CommonUI
		.target(
			name: "CommonUI",
			dependencies: []
		),

		// PictureFeature
		.target(
			name: "PictureFeature",
			dependencies: [
				.composableArchitecture,
				.sharedModels,
				.apodClientLive,
				.commonUI
			]
		),
		.testTarget(
			name: "PictureFeatureTests",
			dependencies: ["PictureFeature"]
		),

		// SharedModels
		.target(
			name: "SharedModels",
			dependencies: []
		),
    ]
)

extension Product {
	static func library(_ name: String) -> Product {
		.library(name: name, targets: [name])
	}
}

extension Target.Dependency {
	static var composableArchitecture: Self { .product(name: "ComposableArchitecture", package: "swift-composable-architecture") }
	// static var snapshotTesting: Self { .product(name: "SnapshotTesting", package: "swift-snapshot-testing") }

	static var appFeature: Self { "AppFeature" }
	static var apodClient: Self { "APODClient" }
	static var apodClientLive: Self { "APODClientLive" }
	static var commonUI: Self { "CommonUI" }
	static var pictureFeature: Self { "PictureFeature" }
	static var sharedModels: Self { "SharedModels" }
}

for target in package.targets {
	target.plugins = (target.plugins ?? []) + [
		.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
	]
}
