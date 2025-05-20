//
//  CocoaViewRepresentable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//

import UIKit
import SwiftUI



struct CocoaView: CocoaViewRepresentable {
    
    var onStart: () -> UIView
    
    var onUpdate: ((UIView) -> Void)?
    
    var sizeFitting: ((ProposedViewSize, UIView, Context) -> CGSize?)?
    
    typealias UIViewType = UIView
}

public protocol CocoaViewRepresentable: UIViewRepresentable {
    
    var onStart: (() -> UIViewType) { get }
    var onUpdate: ((_ uiView: UIViewType) -> Void)? { get }
    var sizeFitting: ((_ proposal: ProposedViewSize, _ uiView: UIViewType, _ context: Context) -> CGSize?)? { get }
    
}

public extension CocoaViewRepresentable {
    
    func makeUIView(context: Context) -> UIViewType {
        return onStart()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard
            let onUpdate
        else {
            return
        }
        onUpdate(uiView)
    }
    
    
}

#Preview {
    
    VStack {
        UIView()
            .body
            .padding(.horizontal)
    }
    
}

struct CocoaViewEnvironmentBridge: ViewModifier {
    
    func body(content: Content) -> some View {
        content
    }
    
}

//extension View {
//    func borderedCaption() -> some View {
//        modifier(BorderedCaption())
//    }
//}




extension UIView {
    
    
    
    @ViewBuilder var body: some View {
        CocoaView {
            self.background(color: .blue)
        }
    }
    
    
    @ViewBuilder func declarativeSetup() -> some View {
        
    }
    
    
    func background(color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
    
}
