//
//  DebugCoreData.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 20/05/25.
//


import SwiftUI
import UIKit
import SwiftData
import CoreData

struct DebugCoreData: View {
    
    @Environment(\.managedObjectContext) var debugObjectContect
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CDDebugModel.title, ascending: true)
    ])
    var items: FetchedResults<CDDebugModel>
    
    var body: some View {
        
        List(items) { item in
            Text(item.title ?? "empty")
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background)
                }
                .frame(maxWidth: .infinity, idealHeight: 200, maxHeight: .infinity, alignment: .bottomTrailing)
                .listRowBackground(
                    CDDebugModelHelper
                        .imageFromData(item.imageData)
                        .resizable()
                        .scaledToFill()
                )
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    DebugCoreData()
        .environment(\.managedObjectContext, PersistenceDebugUtilsController.previewCoreDataContainer.viewContext)
}
