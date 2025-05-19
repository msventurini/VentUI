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
   
    @State private var title: String? = nil
    @State private var imageData: Data? = nil
    @State private var isFavorite: Bool? = nil
    
    var body: some View {
        HStack {
//            Text("a")
            TesteEscaping(debugModel!) { titleData in
                DebugCellRepresentable(title: $title, imageData: $imageData, isFavorite: $isFavorite)
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




struct TesteEscaping<Content: View, DebugData: UniversalDebugData>: View {
    
    let content: Content
    
    init(
        _ data: DebugData,
        @ViewBuilder content: @escaping (_ data: DebugData) -> Content
    )  {
        self.content = content(data)
        
    }
    var body: some View {
        content
    }
    
}




internal struct DebugCellRepresentable: UIViewRepresentable {
    
    @Binding var title: String?
    @Binding var imageData: Data?
    @Binding var isFavorite: Bool?
    
    public var image: UIImage? {
        guard let imageData else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    func makeUIView(context: Context) -> CardCell {
        let uiView = CardCell()
        return uiView
    }
    
    func updateUIView(_ uiView: CardCell, context: Context) {
        uiView.image = image
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
