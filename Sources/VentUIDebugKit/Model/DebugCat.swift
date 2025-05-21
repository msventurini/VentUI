//
//  DebugCat.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit

public enum DebugCat: String, Identifiable, CaseIterable, Hashable {
    
    public var id: String {
        return self.rawValue
    }
    
    case charlotte = "Charlotte"
    case oliver = "Oliver"
    case robin = "Robin"
    
    public var uiImage: UIImage {
        switch self {
        case .charlotte:
            return UIImage(resource: .charlotte)
        case .oliver:
            return UIImage(resource: .oliver)
        case .robin:
            return UIImage(resource: .robin)
        }
    }
    
    var isFavoriteDefaultValue: Bool {
        return false
    }
    
}
