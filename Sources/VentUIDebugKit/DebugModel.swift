//
//  DebugModel.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit
import SwiftData


@Model public final class DebugModel {
    
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
