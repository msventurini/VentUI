//
//  DebugModel.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit
import SwiftData
import CoreData

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

struct CDDebugModelBuilder {
    static func createManagedObjectModel() -> NSManagedObjectModel {
        let managedObjectModel = NSManagedObjectModel()
        
        let debugModelEntityDescription = NSEntityDescription()
        debugModelEntityDescription.name = String(describing: CDDebugModel.self)
        debugModelEntityDescription.managedObjectClassName = String(describing: CDDebugModel.self)
        
        let imageDataDescription = NSAttributeDescription()
        imageDataDescription.name = "imageData"
        imageDataDescription.attributeType = .binaryDataAttributeType
        
        let titleDescription = NSAttributeDescription()
        titleDescription.name = "title"
        titleDescription.attributeType = .stringAttributeType
        
        let isFavoriteDescription = NSAttributeDescription()
        isFavoriteDescription.name = "isFavorite"
        isFavoriteDescription.attributeType = .booleanAttributeType
        
        debugModelEntityDescription.properties = [imageDataDescription, titleDescription, isFavoriteDescription]
        
        managedObjectModel.entities = [debugModelEntityDescription]
        
        return managedObjectModel
    }
}
