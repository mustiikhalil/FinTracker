// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Dependencies",
    dependencies: [
        // Replace these entries with your dependencies.
        .package(url: "https://github.com/google/flatbuffers.git", from: "25.9.23")
    ]
)
