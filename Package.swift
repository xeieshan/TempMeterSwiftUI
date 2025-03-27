// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "TempMeterSwiftUI",
    platforms: [
        .macOS(.v11_0),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "TempMeterSwiftUI",
            targets: ["TempMeterSwiftUI"]),
    ],
    targets: [
        .target(
            name: "TempMeterSwiftUI")
    ]
)
