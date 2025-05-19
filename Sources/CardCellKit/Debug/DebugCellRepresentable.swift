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
    
    let debugModel: DebugModel?
   
    @State private var title: String = ""
    @State private var image: Data = .init()
    @State private var isFavorite: Bool = false
    
    
    
    var body: some View {
        HStack {
            
            
            DebugCellRepresentable(title: $title, image: $image, isFavorite: $isFavorite)
            
            
            
            
            
        }
        .onAppear {
            if let debugModel {
                
                title = debugModel.title
                image = debugModel.image
                isFavorite = debugModel.isFavorite
            }
        }
        
        
        
    }
    
}




internal struct DebugCellRepresentable: UIViewRepresentable {
    
    @Binding var title: String
    @Binding var image: Data
    @Binding var isFavorite: Bool
    
    func makeUIView(context: Context) -> CardCell {
        let uiView = CardCell()
        return uiView
    }
    
    func updateUIView(_ uiView: CardCell, context: Context) {
        uiView.image = UIImage(data: image)
        uiView.title = title

        
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
