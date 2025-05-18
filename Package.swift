// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "VentUI",
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18)
    ],
    
    products: [
        .library(
            name: "VentUI",
            targets: ["VentUI"]),
        .library(name: "CardCellKit", targets: ["CardCellKit"]),
        .library(name: "VentUIDebugKit", targets: ["VentUIDebugKit"]),
    ],
    
    targets: [
        .target(name: "VentUI"),
        .testTarget(name: "VentUITests",dependencies: ["VentUI"]),
        .target(name: "VentUIDebugKit"),
        .target(
            name: "CardCellKit",
            dependencies:
                [
                    .target(name: "VentUIDebugKit")
                ]
        )
    ]
)

