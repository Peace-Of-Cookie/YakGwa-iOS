// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SplashScene",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SplashScene",
            targets: ["SplashScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./Common"),
        .package(path: "./Util"),
        .package(path: "./LoginScene")
    ],
    targets: [
        .target(
            name: "SplashScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "Common", package: "Common"),
                .product(name: "Util", package: "Util"),
                .product(name: "LoginScene", package: "LoginScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "SplashSceneTests",
            dependencies: ["SplashScene"]),
    ]
)