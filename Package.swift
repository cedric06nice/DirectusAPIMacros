// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "DirectusAPIMacros",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "DirectusAPIMacros",
            targets: ["DirectusAPIMacros"]
        ),
        .executable(
            name: "DirectusAPIMacrosClient",
            targets: ["DirectusAPIMacrosClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        .macro(
            name: "DirectusAPIMacrosImpl",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .target(name: "DirectusAPIMacros", dependencies: ["DirectusAPIMacrosImpl"]),
        .executableTarget(name: "DirectusAPIMacrosClient", dependencies: ["DirectusAPIMacros"]),
        .testTarget(
            name: "DirectusAPIMacrosTests",
            dependencies: [
                "DirectusAPIMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
