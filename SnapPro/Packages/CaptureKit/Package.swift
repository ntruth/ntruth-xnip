// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CaptureKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "CaptureKit", targets: ["CaptureKit"])
    ],
    targets: [
        .target(name: "CaptureKit")
    ]
)
