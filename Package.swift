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
        .library(
            name: "SurgeArithmetic",
            targets: [
                "SurgeArithmetic",
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
        .target(
            name: "SurgeArithmetic",
            dependencies: [
                "SurgeCore",
            ]
        ),
        .testTarget(
            name: "SurgeCoreTests",
            dependencies: [
                "SurgeCore",
            ]
        ),
        .testTarget(
            name: "SurgeArithmeticTests",
            dependencies: [
                "SurgeArithmetic",
            ]
        ),
    ]
)
