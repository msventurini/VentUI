// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: Pkg.PkgName,
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18)
    ],
    products: Pkg.allProducts(),
    targets: Pkg.allTargets()
//    targets: [
//        .target(name: Pkg.VentUI.name),
//        .testTarget(name: "VentUITests",dependencies: ["VentUI"]),
//        .target(name: "VentUIDebugKit"),
//        .target(
//            name: "CardCellKit",
//            dependencies: [.target(name: "VentUIDebugKit", condition: .when(traits: ["DEBUG"]))],
//            swiftSettings: [
//                .define("DEBUG", .when(configuration: .debug)),
//                .define("RELEASE", .when(configuration: .release))
//            ]
//        )
//    ]
)

enum BuildConfig: String, Identifiable, CaseIterable, Hashable {
    
    var id: String {
        return self.rawValue
    }
    
    case debug = "DEBUG"
    case release = "RELEASE"
    
    func callAsFunction() -> String {
        return self.rawValue
    }
    
    var buildConfiguration: BuildConfiguration {
        switch self {
        case .debug:
            return .debug
        case .release:
            return .release
        }
    }
    
    var swiftSettingsTraitName: String {
        return self.rawValue
    }
    
}

enum Pkg: String, Identifiable, CaseIterable, Hashable {
    
    
    
    var id: String {
        return self.rawValue
    }
    
    func callAsFunction() -> String {
        return self.rawValue
    }
    
    static let PkgName: String = "VentUI"
    
    case VentUI = "VentUI"
    case VentUITests = "VentUITests"
    case CardCellKit = "CardCellKit"
    case VentUIDebugKit = "VentUIDebugKit"
    
    
    
    var name: String {
        return self.rawValue
    }
    
    var targets: [String] {
        return [self.rawValue]
    }
    
    var isTestTarget: Bool {
        switch self {
        case .VentUITests:
            true
        default:
            false
        }
    }
    
    var isProduct: Bool {
        return !isTestTarget
    }
    
    var product: Product {
        return Product.library(name: self.name, targets: [self.rawValue])
    }
    
    static func allProducts() -> [Product] {
        
        let products = Pkg.allCases
            .filter( { $0.isProduct } )
            .map( { $0.product } )
        return products
        
    }
    
    static func allTargets() -> [Target] {
        
        let targets = Pkg.allCases
            .map( { $0.target } )
        
        return targets
    }
    
    var target: Target {
        switch isTestTarget {
        case true:
            return .testTarget(name: self.name, dependencies: self.dependencies, swiftSettings: self.swiftSettings)

        case false:
            return .target(name: self.name, dependencies: self.dependencies, swiftSettings: self.swiftSettings)
        }
    }
    
    var swiftSettings: [SwiftSetting] {
        return BuildConfig.allCases.map( {.define($0(), .when(configuration: $0.buildConfiguration))} )
    }
    
    var dependencies: [Target.Dependency] {
        switch self {
        case .VentUI:
            [.target(name: Pkg.CardCellKit(), condition: nil)]
        case .VentUITests:
            [.targetItem(name: Pkg.VentUI(), condition: nil)]
        case .CardCellKit:
            [.target(name: Pkg.VentUIDebugKit(), condition: .when(traits: [BuildConfig.debug()]))]
        case .VentUIDebugKit:
            []
        }
    }
}


