// swift-tools-version:5.9
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "SmartText",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "SmartText", targets: ["SmartText"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "3.0.1"))
    ],
    targets: [
        .target(name: "SmartText",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .process("PrivacyInfo.xcprivacy")
                ],
                swiftSettings: [
                    .define("supportsVisionOS", .when(platforms: [.visionOS])),
                ]),
        .testTarget(name: "SmartTextTests",
                    dependencies: [
                        "SmartText",
                        "SpryKit"
                    ],
                    path: "Tests",
                    swiftSettings: [
                        .define("supportsVisionOS", .when(platforms: [.visionOS])),
                    ])
    ]
)
