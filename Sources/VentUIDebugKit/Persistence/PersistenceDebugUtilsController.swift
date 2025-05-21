//
//  PersistenceDebugUtilsController.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//


import SwiftUI
import UIKit
import SwiftData
import CoreData

public struct PersistenceDebugUtilsController {
    
    struct DebugTypeSafeString {
        static let coreDataDebugContainerName = "ProgrammaticCoreDataDebugContainer"
        static let coreDataDebugURLPath = "/dev/null"
    }
    
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
    
    @MainActor
    static var previewCoreDataContainer: NSPersistentContainer = {
        let managedObjectModel = CDDebugModelBuilder.createManagedObjectModel()
        
        let container = NSPersistentContainer(
            name: DebugTypeSafeString.coreDataDebugContainerName,
            managedObjectModel: managedObjectModel
        )
        
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: DebugTypeSafeString.coreDataDebugURLPath)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        let viewContext = container.viewContext
        
        DebugCat
            .allCases
            .forEach { debugCat in
                let item = CDDebugModel(context: viewContext)
                item.imageData = debugCat.uiImage.pngData()
                item.title = debugCat.rawValue
                item.isFavorite = debugCat.isFavoriteDefaultValue
            }
   
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error: \(nsError), \(nsError.userInfo)")
        }
        
        return container
    }()
}
