// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: Pkg.PkgName,
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18),
        .macOS(.v15)
    ],
    products: Pkg.allProducts(),
    targets: Pkg.allTargets()
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
    
    case ventUI = "VentUI"
    case ventUITests = "VentUITests"
    case cardCellKit = "CardCellKit"
    case cocoaAdapterKit = "CocoaAdapterKit"
    case ventUIDebugKit = "VentUIDebugKit"
    case releaseOnlyPkg = "ReleaseOnlyPkg"
    case swiftUIComponentKit = "SwiftUIComponentKit"
    case debugOnlyPkg = "DebugOnlyPkg"
    
    
    
    var name: String {
        return self.rawValue
    }
    
    var targets: [String] {
        return [self.rawValue]
    }
    
    var isTestTarget: Bool {
        switch self {
        case .ventUITests:
            true
        default:
            false
        }
    }
    
    var isProduct: Bool {
        return !isTestTarget
    }
    
    var product: Product {
        return Product.library(name: self.name, type: .dynamic,targets: [self.rawValue])
    }
    
    static func allProducts() -> [Product] {
        
        let products = Pkg.allCases
            .filter( { $0.isProduct } )
            .map( { $0.product } )
        return products
        
    }
    
    static func allTargets(exept target: Pkg? = nil) -> [Target] {
        
        guard let target else {
            let targets = Pkg.allCases
                .map( { $0.target } )
            
            return targets
        }
        
        let targets = Pkg.allCases
            .filter( { $0 != target } )
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
        case .ventUI:
            [
                .target(name: Pkg.cocoaAdapterKit(), condition: nil),
                .target(name: Pkg.cardCellKit(), condition: nil),
                .target(name: Pkg.ventUIDebugKit(), condition: .when(traits: [BuildConfig.debug()])),
                .target(name: Pkg.debugOnlyPkg(), condition: .when(traits: [BuildConfig.debug()])),
                .target(name: Pkg.releaseOnlyPkg(), condition: .when(traits: [BuildConfig.release()])),
                .target(name: Pkg.swiftUIComponentKit(), condition: nil)
            ]
        case .ventUITests:
            [
                .targetItem(name: Pkg.ventUI(), condition: nil)
            ]
        case .cardCellKit:
            [
                .target(name: Pkg.ventUIDebugKit(), condition: .when(traits: [BuildConfig.debug()])),
                .target(name: Pkg.cocoaAdapterKit(), condition: .when(traits: [BuildConfig.debug()]))//tirar depois
            ]
        case .ventUIDebugKit:
            [
                .target(name: Pkg.cocoaAdapterKit(), condition: nil)
            ]
        case .cocoaAdapterKit:
            []
        case .swiftUIComponentKit:
            []
        case .releaseOnlyPkg:
            []
        case .debugOnlyPkg:
            []
        }
    }
}
//
//// swift-tools-version: 6.1
//// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//import PackageDescription
//import Foundation
//
//let package = Package(
//    name: Pkg.PkgName,
//    platforms: [
//        .iOS(.v18),
//        .macCatalyst(.v18),
//        .macOS(.v15)
//    ],
//    products: Pkg.allProducts(),
//    targets: Pkg.allTargets()
//)
//
//enum BuildConfig: String, Identifiable, CaseIterable, Hashable {
//    
//    var id: String {
//        return self.rawValue
//    }
//    
//    case debug = "DEBUG"
//    case release = "RELEASE"
//    
//    func callAsFunction() -> String {
//        return self.rawValue
//    }
//    
//    var buildConfiguration: BuildConfiguration {
//        switch self {
//        case .debug:
//            return .debug
//        case .release:
//            return .release
//        }
//    }
//    
//    var swiftSettingsTraitName: String {
//        return self.rawValue
//    }
//    
//}
//
//enum Pkg: String, Identifiable, CaseIterable, Hashable {
//    
//    
//    
//    var id: String {
//        return self.rawValue
//    }
//    
//    func callAsFunction() -> String {
//        return self.rawValue
//    }
//    
//    static let PkgName: String = "VentUI"
//    
//    case ventUI = "VentUI"
//    case ventUITests = "VentUITests"
//    case cardCellKit = "CardCellKit"
//    case cocoaAdapterKit = "CocoaAdapterKit"
//    case ventUIDebugKit = "VentUIDebugKit"
//    case releaseOnlyPkg = "ReleaseOnlyPkg"
//    case swiftUIComponentKit = "SwiftUIComponentKit"
//    case debugOnlyPkg = "DebugOnlyPkg"
//    
//    
//    
//    var name: String {
//        return self.rawValue
//    }
//    
//    var targets: [String] {
//        return [self.rawValue]
//    }
//    
//    var isTestTarget: Bool {
//        switch self {
//        case .ventUITests:
//            true
//        default:
//            false
//        }
//    }
//    
//    var isProduct: Bool {
//        return !isTestTarget
//    }
//    
//    var product: Product {
//        return Product.library(name: self.name, type: .dynamic,targets: [self.rawValue])
//    }
//    
//    static func allProducts() -> [Product] {
//        
//        let products = Pkg.allCases
//            .filter( { $0.isProduct } )
//            .map( { $0.product } )
//        return products
//        
//    }
//    
//    static func allTargets(exept target: Pkg? = nil) -> [Target] {
//        
//        guard let target else {
//            let targets = Pkg.allCases
//                .map( { $0.target } )
//            
//            return targets
//        }
//        
//        let targets = Pkg.allCases
//            .filter( { $0 != target } )
//            .map( { $0.target } )
//        
//        return targets
//    }
//    
//    var target: Target {
//        switch isTestTarget {
//        case true:
//            return .testTarget(name: self.name, dependencies: self.dependencies, swiftSettings: self.swiftSettings)
//            
//        case false:
//            return .target(name: self.name, dependencies: self.dependencies, swiftSettings: self.swiftSettings)
//        }
//    }
//    
//    var swiftSettings: [SwiftSetting] {
//        return BuildConfig.allCases.map( {.define($0(), .when(configuration: $0.buildConfiguration))} )
//    }
//    
//    var dependencies: [Target.Dependency] {
//        switch self {
//        case .ventUI:
//            [
//                .target(name: Pkg.cocoaAdapterKit(), condition: nil),
//                .target(name: Pkg.cardCellKit(), condition: nil),
//                .target(name: Pkg.ventUIDebugKit(), condition: .when(traits: [BuildConfig.debug()])),
//                .target(name: Pkg.debugOnlyPkg(), condition: .when(traits: [BuildConfig.debug()])),
//                .target(name: Pkg.releaseOnlyPkg(), condition: .when(traits: [BuildConfig.release()])),
//                .target(name: Pkg.swiftUIComponentKit(), condition: nil)
//            ]
//        case .ventUITests:
//            [
//                .targetItem(name: Pkg.ventUI(), condition: nil)
//            ]
//        case .cardCellKit:
//            [
//                .target(name: Pkg.ventUIDebugKit(), condition: .when(traits: [BuildConfig.debug()])),
//                .target(name: Pkg.cocoaAdapterKit(), condition: .when(traits: [BuildConfig.debug()]))//tirar depois
//            ]
//        case .ventUIDebugKit:
//            [
//                .target(name: Pkg.cocoaAdapterKit(), condition: nil)
//            ]
//        case .cocoaAdapterKit:
//            []
//        case .swiftUIComponentKit:
//            []
//        case .releaseOnlyPkg:
//            []
//        case .debugOnlyPkg:
//            []
//        }
//    }
//}
