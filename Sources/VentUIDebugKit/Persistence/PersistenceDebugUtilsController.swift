//
//  PersistenceDebugUtilsController.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//


import SwiftUI
import UIKit
import SwiftData

public class PersistenceDebugUtilsController {
    @MainActor
    static var previewModelContainer: ModelContainer {
        let container = try! ModelContainer (
            for: DebugModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        DebugCat.allCases
            .map( { DebugModel(imageData: $0.uiImage.pngData()!, title: $0.rawValue) } )
            .forEach( { container.mainContext.insert($0) } )
        
        return container
    }
}
