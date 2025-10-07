// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ExportKit",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "ExportKit", targets: ["ExportKit"])
    ],
    dependencies: [
        .package(path: "../Annotator"),
        .package(path: "../SnapProCore")
    ],
    targets: [
        .target(name: "ExportKit", dependencies: ["Annotator", "SnapProCore"])
    ]
)
