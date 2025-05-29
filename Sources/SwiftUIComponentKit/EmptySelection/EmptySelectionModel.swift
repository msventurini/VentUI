//
//  EmptySelectionModel.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import Foundation

public struct EmptySelectionModel {
    
    public let labelText: String
    public let systemImage: String
    public let description: String
    
    public init(labelText: String, systemImage: String, description: String) {
        self.labelText = labelText
        self.systemImage = systemImage
        self.description = description
    }
    
}
