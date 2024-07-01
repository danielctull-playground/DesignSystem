// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .macCatalyst(.v17),
        .tvOS(.v17),
        .visionOS(.v1),
        .watchOS(.v10),
    ],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "DesignSystemStyle", targets: ["DesignSystemStyle"]),
    ],
    targets: [

        .target(name: "DesignSystem"),

        .target(
            name: "DesignSystemStyle",
            dependencies: [
                "DesignSystem",
            ]
        ),

        .executableTarget(
            name: "Demo",
            dependencies: [
                "DesignSystem",
                "DesignSystemStyle",
            ]
        ),
    ]
)
