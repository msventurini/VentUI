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
        // Products define the executables and libraries a package produces, making them visible to other packages.
        
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

enum VentUITarget: String, Identifiable, CaseIterable, Hashable {

    var id: String {
        return self.rawValue
    }
    
    case VentUI = "VentUI"
    case VentUITests = "VentUITests"
    case VentUIDebugKit = "VentUIDebugKit"
    case CardCellKit = "CardCellKit"
    
    var target: Target {
        
        switch self {
        case .VentUI:
                .target(name: "VentUI")
        case .VentUITests:
                .testTarget(name: "VentUITests",dependencies: ["VentUI"])
        case .VentUIDebugKit:
                .target(name: "VentUIDebugKit")
        case .CardCellKit:
                .target(
                    name: "CardCellKit",
                    dependencies:
                        [
                            .target(name: "VentUIDebugKit")
                        ]
                )
        }
        
        
    }
    
    static func getAllTargets() -> [Target] {
        return VentUITarget.allCases.compactMap( { $0.target } )
    }
    
}
