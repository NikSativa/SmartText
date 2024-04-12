// swift-tools-version:5.8
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "SmartText",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "SmartText", targets: ["SmartText"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.2.2"))
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
