// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Integration",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "Integration", targets: ["Integration"])
    ],
    dependencies: [
        .package(path: "../CaptureKit")
    ],
    targets: [
        .target(name: "Integration", dependencies: ["CaptureKit"])
    ]
)
