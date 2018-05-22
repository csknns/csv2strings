// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "csv2strings",
    dependencies: [
        .package(url: "https://github.com/Flinesoft/CSVImporter.git", .upToNextMajor(from: "1.8.0"))
    ],
    targets: [
        .target(
            name: "csv2strings",
            dependencies: ["CSVImporter"]),
    ]
)
