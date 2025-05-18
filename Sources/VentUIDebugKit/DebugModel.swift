//
//  DebugModel.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit
import Observation

@Observable public class DebugModel {
    public var image: UIImage?
    public var title: String?
    public var isFavorite: Bool?
    
    public init(image: UIImage? = nil, title: String? = nil, isFavorite: Bool? = nil) {
        self.image = image
        self.title = title
        self.isFavorite = isFavorite
    }
}
