// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Annotator",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "Annotator", targets: ["Annotator"])
    ],
    dependencies: [
        .package(path: "../SnapProCore")
    ],
    targets: [
        .target(name: "Annotator", dependencies: ["SnapProCore"])
    ]
)
