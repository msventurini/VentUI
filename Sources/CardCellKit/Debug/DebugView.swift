//
//  DebugView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit

internal struct DebugView: UIViewRepresentable {
    
    @Binding var image: UIImage?
    
    func makeUIView(context: Context) -> CardCell {
        let uiView = CardCell()
        return uiView
    }
    
    func updateUIView(_ uiView: CardCell, context: Context) {
        uiView.image = image
    }
    
    typealias UIViewType = CardCell
    
}
//internal struct DebugView: UIViewRepresentable {
//    
//
//    func makeUIView(context: Context) -> some CardCell {
//
////        view.image = UIImage(systemName: "Person")
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//        uiView
//        
//    }
//
//    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
//        return .init(width: 250, height: 200)
//    }
//}
