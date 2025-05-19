//
//  DebugView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//

import SwiftUI
import UIKit
import Observation
import VentUIDebugKit
import SwiftData


struct DebugView: View {
    
    @State var debugModel: DebugModel? = nil
    
    var body: some View {
        
        
            VStack {
                CollectionCellView {
                    CardCell()
                }
                CollectionCellView(item: $debugModel) {
                    CardCell()
                }

                
                CollectionCellView(item: $debugModel) {
                    
                    CardCell()
                    
                } onUpdate: { debugData, uiView in
                    
                    uiView.image = debugData.image
                    uiView.title = debugData.title
                    uiView.isFavorite = debugData.isFavorite
                    
                }
            }
        
        
        
    }
    
}




struct TesteEscaping<Content: View>: View {
    
    let content: Content
    
    init(
        _ debugData: Binding<DebugModel?>,
        @ViewBuilder content: @escaping (_ debugData: Binding<DebugModel?>) -> Content
    )  {
        self.content = content(debugData)
        
    }
    var body: some View {
        content
    }
    
}




struct CollectionCellView<CollectionItem: DebugModel>: CollectionViewCellRepresentable {
    
    @Binding var item: CollectionItem?
    
    var onStart: (() -> CardCell)
    var updateAction: ((_ item: CollectionItem, _ uiView: CardCell) -> Void)?

}






#Preview(traits: .modifier(PreviewDebugHelper())) {
    
    @Previewable @Query(sort: \DebugModel.title) var debugModels: [DebugModel]
    
    @Previewable @Environment(\.modelContext) var modelContext
    ScrollView {
        ForEach(debugModels) { model in
            DebugView(debugModel: model)
        }
    }
    
}
