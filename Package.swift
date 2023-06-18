// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SetlistFMKit",
    platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v15), .watchOS(.v10), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SetlistFMKit",
            targets: ["SetlistFMKit"]),
    ],
    dependencies: [
        .package(path: "../DrillURL")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SetlistFMKit",
            dependencies: [
                .product(name: "DrillURL", package: "DrillURL")
            ]),

        .testTarget(
            name: "SetlistFMKitTests",
            dependencies: ["SetlistFMKit"]),
    ]
)
