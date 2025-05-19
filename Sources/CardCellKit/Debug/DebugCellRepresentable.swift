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
                
                DebugCellRepresentable(debugData: $debugData) {
                    CardCell()
                } onUpdate: { debugData, uiView in
                    
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

protocol ContentViewUpdatable: UIViewRepresentable {
    
    associatedtype ObservableModel: Observation.Observable
    
//    associatedtype ViewCreationFunction = (() -> UIViewType)
    
    
    
    typealias onStartType = (() -> UIViewType)
    typealias onUpdateType = ((_ observableModel: ObservableModel?, _ uiView: UIViewType) -> Void)
    

    init(
        debugData: Binding<ObservableModel?>,
        onStart: @escaping onStartType,
        onUpdate: @escaping onUpdateType
    )
    
}

extension ContentViewUpdatable {
    
    
    
    
    
}


internal struct DebugCellRepresentable: ContentViewUpdatable {

    @Binding var debugData: DebugModel?
    var onStart: (() -> CardCell)
    var onUpdate: ((_ observableModel: DebugModel?, _ uiView: CardCell) -> Void)

    init(
        debugData: Binding<DebugModel?>,
        onStart: @escaping () -> CardCell,
        onUpdate: @escaping (_ model: DebugModel?, _ uiView: CardCell) -> Void
    ) {
        self.onStart = onStart
        self.onUpdate = onUpdate
        self._debugData = debugData
    }
    
    func makeUIView(context: Context) -> CardCell {
        return onStart()
    }
    
    func updateUIView(_ uiView: CardCell, context: Context) {
        onUpdate(debugData, uiView)
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
