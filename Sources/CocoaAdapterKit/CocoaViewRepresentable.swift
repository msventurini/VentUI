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
    
    init(
        onStart: @escaping () -> UIViewType,
        onUpdate: ((_ uiView: UIViewType) -> Void)?,
        sizeFitting: ((_ proposal: ProposedViewSize, _ uiView: UIViewType, _ context: Context) -> CGSize?)?
    )
    
}

public extension CocoaViewRepresentable {
    
    
    init(onStart: @escaping () -> UIViewType) {
        self.init(
            onStart: onStart,
            onUpdate: nil,
            sizeFitting: nil
        )
    }
    
    init(
        onStart: @escaping () -> UIViewType,
        onUpdate: @escaping ((_ uiView: UIViewType) -> Void)
    ) {
        self.init(
            onStart: onStart,
            onUpdate: onUpdate,
            sizeFitting: nil
        )
    }
    
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
        
        guard let sizeFitting else {
            return proposal.replacingUnspecifiedDimensions()
        }
        
        return sizeFitting(proposal, uiView, context)
    }
}

#Preview {
    CocoaView {
        UIView()
            .background(color: .brown)
    }
    //    CocoaView {
    //        let view = UIView()
    //        view.backgroundColor = .red
    //        return view
    //    } onUpdate: { uiView in
    //
    //    } sizeFitting: { proposedViewSize, uiView, context in
    //        return .init(width: 200, height: 200)
    //    }
}

extension UIView {
    
    func background(color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    
    
}
