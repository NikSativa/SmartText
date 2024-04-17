// swift-tools-version:5.7
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "SmartText",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "SmartText", targets: ["SmartText"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.2.3"))
    ],
    targets: [
        .target(name: "SmartText",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "SmartTextTests",
                    dependencies: [
                        "SmartText",
                        "SpryKit"
                    ],
                    path: "Tests")
    ]
)
