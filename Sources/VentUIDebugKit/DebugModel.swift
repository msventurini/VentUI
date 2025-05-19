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
    
    var imageData: ImageData? { get set }
    var image: UIImage? { get }
    var title: TitleData? { get set }
    var isFavorite: FavoriteData? { get set }
}

@Model public final class DebugModel: UniversalDebugData {
    
    
    public var imageData: Data?
    public var title: String?
    public var isFavorite: Bool?
    public var image: UIImage? {
        guard
            let imageData
        else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    
    public init(imageData: Data? = nil, title: String? = nil, isFavorite: Bool? = nil) {
        self.imageData = imageData
        self.title = title
        self.isFavorite = isFavorite
    }
}




//
//
//
//#Preview(traits: .modifier(PreviewDebugHelper())) {
//    Teste()
//    
//}
