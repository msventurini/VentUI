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
    @Query(sort: \DebugModel.title) var debugModels: [DebugModel]
    
    var body: some View {
        ScrollView {
            VStack {
                
                ForEach(debugModels) { modelItem in
                    
                    CollectionCellView(item: modelItem) { item in
                        CardCell()
                    } updateAction: { item, uiView in
                        uiView.image = item.image
                        uiView.title = item.title
                        uiView.isFavorite = item.isFavorite
                    }
                }
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
    
    let item: CollectionItem
    
    var onStart: ((_ item: CollectionItem) -> CardCell)
    var updateAction: ((_ item: CollectionItem, _ uiView: CardCell) -> Void)?
    
}






#Preview(traits: .modifier(PreviewDebugHelper())) {
    DebugView()
}
