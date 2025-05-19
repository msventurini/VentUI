//
//  DebugModel.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit
import SwiftData

public protocol UniversalDebugData {
    
//    associatedtype ImageData: DataProtocol
//    associatedtype TitleData: StringProtocol
//    associatedtype FavoriteData: ExpressibleByBooleanLiteral
    
    associatedtype ImageData = Data
    associatedtype TitleData = String
    associatedtype FavoriteData = Bool
    
    var image: ImageData { get set }
    var title: TitleData { get set }
    var isFavorite: FavoriteData { get set }
}

@Model public final class DebugModel: UniversalDebugData {
    
//    public typealias ImageData = Data
    public typealias TitleData = String
    public typealias FavoriteData = Bool
    
    public var image: Data
    public var title: String
    public var isFavorite: Bool
    
    public init(image: Data, title: String) {
        self.image = image
        self.title = title
        self.isFavorite = false
    }
}







#Preview(traits: .modifier(PreviewDebugHelper())) {
    Teste()
    
}
