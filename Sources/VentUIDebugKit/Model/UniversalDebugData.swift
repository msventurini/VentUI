//
//  UniversalDebugData.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//


import SwiftUI
import UIKit
import SwiftData

public protocol UniversalDebugData {
    
    associatedtype ImageData = Data
    associatedtype TitleData = String
    associatedtype FavoriteData = Bool
    
    var imageData: ImageData? { get set }
    var image: UIImage? { get }
    var title: TitleData? { get set }
    var isFavorite: FavoriteData? { get set }
    
}