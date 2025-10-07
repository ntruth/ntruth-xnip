// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "OCRKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "OCRKit", targets: ["OCRKit"])
    ],
    targets: [
        .target(name: "OCRKit")
    ]
)
