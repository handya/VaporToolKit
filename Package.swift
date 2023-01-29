// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VaporToolKit",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .library(
            name: "VaporToolKit",
            targets: ["VaporToolKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.69.1"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.6.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.5.0")
    ],
    targets: [
        .target(
            name: "VaporToolKit",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Vapor", package: "vapor")
            ]),
        .testTarget(
            name: "VaporToolKitTests",
            dependencies: ["VaporToolKit"]),
    ]
)
