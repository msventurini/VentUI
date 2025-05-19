//
//  PreviewDebugHelper.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//


import SwiftUI
import UIKit
import SwiftData

public struct PreviewDebugHelper: PreviewModifier {
    
    public struct EnvironmentDebugData {
        let swiftDataDebugContainer: ModelContainer
        
        
        init(swiftDataContainer swiftDataDebugContainer: ModelContainer) {
            self.swiftDataDebugContainer = swiftDataDebugContainer
        }
    }
    
    public static func makeSharedContext() throws -> EnvironmentDebugData {
        
        let debugContext: EnvironmentDebugData = .init(swiftDataContainer: PersistenceDebugUtilsController.previewModelContainer)
        
        return debugContext
    }
    
    public init() {
        
    }
    
    public func body(content: Content, context: EnvironmentDebugData) -> some View {
        content
            .modelContainer(context.swiftDataDebugContainer)
            
        
    }
    
}
