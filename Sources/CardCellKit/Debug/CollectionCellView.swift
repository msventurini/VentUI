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




internal struct CollectionCellView<CollectionItem: DebugModel>: CollectionViewCellRepresentable {
    
    @Binding var item: CollectionItem?
    
    var onStart: (() -> CardCell)
    var onUpdate: ((_ item: CollectionItem, _ uiView: CardCell) -> Void)?
    
    init(onStart: @escaping () -> CardCell) {
        self.onStart = onStart
        self.onUpdate = nil
        self._item = .constant(nil)
    }
    
    init(
        item: Binding<CollectionItem?>,
        onStart: @escaping () -> CardCell,
        onUpdate: @escaping ((_ item: CollectionItem, _ uiView: CardCell) -> Void)
    ) {
        self.onStart = onStart
        self.onUpdate = onUpdate
        self._item = item
    }
    
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
