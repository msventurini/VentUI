//
//  CocoaViewRepresentable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//

import UIKit
import SwiftUI



struct CocoaView: CocoaViewRepresentable {
    typealias UIViewType = UIView
    
    var onStart: StartFunction
    
    var onUpdate: UpdateFunction?
    
    var sizeFitting: SizeFittingFunction?
    
}


public protocol CocoaViewRepresentable: UIViewRepresentable {
    
    typealias StartFunction = ((_ context: UIViewRepresentableContext<Self>) -> UIViewType)
    typealias UpdateFunction = ((_ uiView: UIViewType, _ context: Context) -> Void)
    typealias SizeFittingFunction = (_ proposal: ProposedViewSize, _ uiView: UIViewType, _ context: Context) -> CGSize?

    var onStart: (StartFunction) { get }
    var onUpdate: (UpdateFunction)? { get }
    var sizeFitting: (SizeFittingFunction)? { get }
    
    func makeUIView(context: Context) -> UIViewType
    func updateUIView(_ uiView: UIViewType, context: Context)
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize?
    
}

public extension CocoaViewRepresentable {
    
    func makeUIView(context: Context) -> UIViewType {
        return onStart(context)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard
            let onUpdate
        else {
            return
        }
        onUpdate(uiView, context)
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

    }
    
}

struct CocoaViewEnvironmentBridge: ViewModifier {
    
    func body(content: Content) -> some View {
        content
    }
    
}

extension UIView {
    
    @ViewBuilder var body: some CocoaViewRepresentable {

        CocoaView { context in
            let view = self
            self.backgroundColor = .purple
            return view
                
        }
    }
    
    
    @ViewBuilder func declarativeSetup() -> some View {
        
    }
    
    
    func background(color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
    
}


