// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "DynamicJSON",
    products: [
        .library(name: "DynamicJSON", targets: ["DynamicJSON"]),
    ],
    targets: [
        .target(name: "DynamicJSON", dependencies: [], path: "Sources"),
    ]
)
