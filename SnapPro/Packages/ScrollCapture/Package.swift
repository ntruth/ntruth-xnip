// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ScrollCapture",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "ScrollCapture", targets: ["ScrollCapture"])
    ],
    targets: [
        .target(name: "ScrollCapture")
    ]
)
