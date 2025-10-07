// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SnapProCore",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "SnapProCore", targets: ["SnapProCore"])
    ],
    targets: [
        .target(name: "SnapProCore"),
        .testTarget(name: "SnapProCoreTests", dependencies: ["SnapProCore"], path: "Tests")
    ]
)
