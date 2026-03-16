// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RSToast",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "RSToast",
            targets: ["RSToast"]
        ),
    ],
    targets: [
        .target(
            name: "RSToast",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "RSToastTests",
            dependencies: ["RSToast"],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
                .swiftLanguageMode(.v6)
            ]
        ),
    ]
)
