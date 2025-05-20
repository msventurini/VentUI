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
import CocoaAdapterKit


struct DebugView: View {
    @Query(sort: \DebugModel.title) var debugModels: [DebugModel]
    
    var body: some View {
        ScrollView {
            VStack {
                
                ForEach(debugModels) { modelItem in
                    testeRep {
                        let labelView = UILabel()
                        labelView.text = modelItem.title
                        return labelView
                    } updateAction: { view in
                        
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


struct testeRep: CocoaViewRepresentable {
    var onStart: () -> UIView
    
    var updateAction: ((UIView) -> Void)?
    
    typealias UIViewType = UIView
    
    
}


#Preview(traits: .modifier(PreviewDebugHelper())) {
    DebugView()
}
