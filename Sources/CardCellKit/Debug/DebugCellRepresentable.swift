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
   
    @State private var title: String? = nil
    @State private var imageData: Data? = nil
    @State private var isFavorite: Bool? = nil
    
    var body: some View {
        HStack {

            TesteEscaping($debugModel) { $debugData in
                DebugCellRepresentable(debugData: $debugData)
            }
        }
        .onAppear {
            if let debugModel {
                
                title = debugModel.title
                imageData = debugModel.imageData
                isFavorite = debugModel.isFavorite
            }
        }
        
        
        
    }
    
}




struct TesteEscaping<Content: View, DebugData: DebugModel>: View {
    
    let content: Content
    
    init(
        _ debugData: Binding<DebugData?>,
        @ViewBuilder content: @escaping (_ debugData: Binding<DebugData?>) -> Content
    )  {
        self.content = content(debugData)
        
    }
    var body: some View {
        content
    }
    
}




internal struct DebugCellRepresentable: UIViewRepresentable {
    
    @Binding var debugData: DebugModel?
    
    func makeUIView(context: Context) -> CardCell {
        let uiView = CardCell()
        return uiView
    }
    
    func updateUIView(_ uiView: CardCell, context: Context) {
        
        guard let debugData else {
            uiView.image = nil
            uiView.title = nil
            uiView.isFavorite = nil
            return
        }
        
        uiView.image = debugData.image
        uiView.title = debugData.title
        uiView.isFavorite = debugData.isFavorite
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        return .init(width: 250, height: 200)
    }
    
    typealias UIViewType = CardCell
    
}

#Preview(traits: .modifier(PreviewDebugHelper())) {
    
    @Previewable @Query(sort: \DebugModel.title) var debugModels: [DebugModel]
    
    @Previewable @Environment(\.modelContext) var modelContext
    
    ForEach(debugModels) { model in
        DebugView(debugModel: model)
    }
    
}
