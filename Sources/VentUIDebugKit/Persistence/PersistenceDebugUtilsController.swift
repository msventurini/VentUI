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
    
    
    
//    
//    static var previewCoreDataContainer: NSPersistentContainer {
//        let managedObjectModel = PersistenceDebugUtilsController.createManagedObjectModel()
//        
//        let container = NSPersistentContainer(
//            name: DebugTypeSafeString.coreDataDebugContainerName,
//            managedObjectModel: managedObjectModel
//        )
//        
//        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: DebugTypeSafeString.coreDataDebugURLPath)
//        
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//     
//        let viewContext = container.viewContext
//        
//        DebugCat.allCases
//            .map { debugCat in
//                let item = CDDebugModel(context: viewContext)
//                item.imageData = debugCat.uiImage.pngData()
//                item.title = debugCat.
//            }
//            .map( { DebugModel(imageData: $0.uiImage.pngData()!, title: $0.rawValue) } )
//            .forEach( { container.mainContext.insert($0) } )
//            .forEach( { container.mainContext.insert($0) } )
//            .forEach { debugModel in
//                let item = 
//            }
        
        
    }
    
//    
//    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Shelf(context: viewContext)
//            newItem.number = Int64.random(in: 0...9999)
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//    
//    private static func createManagedObjectModel() -> NSManagedObjectModel {
//        let managedObjectModel = NSManagedObjectModel()
//        
//        let debugModelEntityDescription = NSEntityDescription()
//        debugModelEntityDescription.name = String(describing: CDDebugModel.self)
//        debugModelEntityDescription.managedObjectClassName = String(describing: CDDebugModel.self)
//        
//        let imageDataDescription = NSAttributeDescription()
//        imageDataDescription.name = "imageData"
//        imageDataDescription.attributeType = .binaryDataAttributeType
//        
//        let titleDescription = NSAttributeDescription()
//        titleDescription.name = "title"
//        titleDescription.attributeType = .stringAttributeType
//        
//        let isFavoriteDescription = NSAttributeDescription()
//        isFavoriteDescription.name = "isFavorite"
//        isFavoriteDescription.attributeType = .booleanAttributeType
//        
//        debugModelEntityDescription.properties = [imageDataDescription, titleDescription, isFavoriteDescription]
//        
//        managedObjectModel.entities = [debugModelEntityDescription]
//        
//        return managedObjectModel
//    }
    
//}


@objc(CDDebugModel)
public class CDDebugModel: NSManagedObject {

}


extension CDDebugModel {

    @NSManaged public var imageData: Data?
    @NSManaged public var title: String?
    @NSManaged public var isFavorite: Bool
    

}

extension CDDebugModel : Identifiable {

}


//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
//        return NSFetchRequest<Book>(entityName: "Book")
//    }


//@Model public final class DebugModel: UniversalDebugData {
//    
//    
//    public var imageData: Data?
//    public var title: String?
//    public var isFavorite: Bool?
//    public var image: UIImage? {
//        guard
//            let imageData
//        else {
//            return nil
//        }
//        return UIImage(data: imageData)
//    }
//    
//    
//    public init(imageData: Data? = nil, title: String? = nil, isFavorite: Bool? = nil) {
//        self.imageData = imageData
//        self.title = title
//        self.isFavorite = isFavorite
//    }
//}
