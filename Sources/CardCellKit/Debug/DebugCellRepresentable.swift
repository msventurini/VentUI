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




struct DebugView: View {
    
    @State var catModel: DebugModel
    
    var titleButtonLabel: String {
        (catModel.title == nil) ? "Add Title" : "Remove Title"
    }
    
    
    
    init() {
     
        self.catModel = .init(image: DebugCat.oliver.uiImage, title: DebugCat.oliver.id)
        
    }
    
    var body: some View {
        HStack {
            
            VStack {
                
                
                Canvas { context, size in
                    context.stroke(
                        Path(ellipseIn: CGRect(origin: .zero, size: size)),
                        with: .color(.green),
                        lineWidth: 4)
                }
                .frame(width: 300, height: 200)
                
                .border(Color.blue)
                
                ZStack {
                    
                    Image(systemName: "ladybug")
                        .foregroundStyle(.blue)
                        .fontWeight(.black)
                        

                    Image(systemName: "ladybug.fill")
                        .symbolRenderingMode(.multicolor)
                        .fontWeight(.thin)
                        .background {
                            Image(systemName: "ladybug")
                                .fontWeight(.semibold)
                        }
                        .font(.largeTitle)
                    
                        
                }
                
                
                Button {
                    
                    if catModel.title == nil {
                        catModel.title = DebugCat.oliver.rawValue
                    } else {
                        catModel.title = nil
                    }
                    
                } label: {
                    Text(titleButtonLabel)
                }
                .buttonStyle(.borderedProminent)
                DebugCellRepresentable(debugModel: $catModel)
            }
            
            
            
            VStack {
                
                
                
            }
            .frame(width: 110)
            
            
        }
        
        
        
    }
    
}

internal struct DebugCellRepresentable: UIViewRepresentable {
    
    @Binding var debugModel: DebugModel
    
    
    func makeUIView(context: Context) -> CardCell {
        let uiView = CardCell()
        return uiView
    }
    
    func updateUIView(_ uiView: CardCell, context: Context) {
        uiView.image = debugModel.image

    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        return .init(width: 250, height: 200)
    }
    
    typealias UIViewType = CardCell
    
}

#Preview {
    DebugView()
//    DebugCellRepresentable()
}
