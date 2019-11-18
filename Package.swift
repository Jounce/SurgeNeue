// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SurgeCore",
    products: [
        .library(
            name: "SurgeCore",
            targets: [
                "SurgeCore",
            ]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SurgeCore",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "SurgeCoreTests",
            dependencies: [
                "SurgeCore",
            ]
        ),
    ]
)
