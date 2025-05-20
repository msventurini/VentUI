//
//  CocoaViewRepresentable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//

import UIKit
import SwiftUI



struct CocoaView: CocoaViewRepresentable {
    var onStart: StartFunction
    
    var onUpdate: UpdateFunction?
    
    var sizeFitting: SizeFittingFunction?
    
    typealias UIViewType = UIView
}


public protocol CocoaViewRepresentable: UIViewRepresentable {

    typealias StartFunction = (() -> UIViewType)
    typealias UpdateFunction = ((_ uiView: UIViewType) -> Void)
    typealias SizeFittingFunction = (_ proposal: ProposedViewSize, _ uiView: UIViewType, _ context: Context) -> CGSize?

    var onStart: (StartFunction) { get }
    var onUpdate: (UpdateFunction)? { get }
    var sizeFitting: (SizeFittingFunction)? { get }
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
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        
        guard let sizeFitting else { return proposal.replacingUnspecifiedDimensions()}
        
        return sizeFitting(proposal, uiView, context)
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

extension UIView {
    
    
    
    @ViewBuilder var body: some CocoaViewRepresentable {
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
