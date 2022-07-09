// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "CombineFlow",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CombineFlow",
            targets: ["CombineFlow"]),
    ],
    targets: [
        .target(
            name: "CombineFlow"
        )
    ],
    swiftLanguageVersions: [.v5]
)
