// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "csv2strings",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(
            name: "csv2strings",
            targets: ["csv2strings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Flinesoft/CSVImporter.git", .upToNextMajor(from: "1.8.0"))
    ],
    targets: [
        .target(
            name: "csv2strings",
            dependencies: ["libcsv2strings"]),
        .target(
            name: "libcsv2strings",
            dependencies: ["CSVImporter"]),
    ],
    swiftLanguageVersions: [.v5]
)
