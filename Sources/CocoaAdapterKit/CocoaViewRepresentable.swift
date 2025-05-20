//
//  CocoaViewRepresentable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//

import UIKit
import SwiftUI

public protocol CocoaViewResizable where Self: CocoaViewRepresentable {
    
    func sizeFitting(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize?
    
}


public protocol CocoaViewRepresentable: UIViewRepresentable {
    
    var onStart: (() -> UIViewType) { get }
    var updateAction: ((_ uiView: UIViewType) -> Void)? { get }

    init(
        onStart: @escaping () -> UIViewType,
        updateAction: ((_ uiView: UIViewType) -> Void)?
    )
    
}

public extension CocoaViewRepresentable {
    
    
    init(onStart: @escaping () -> UIViewType) {
        self.init(
            onStart: onStart, updateAction: nil
        )
    }
    
    init(
        onStart: @escaping () -> UIViewType,
        onUpdate: @escaping ((_ uiView: UIViewType) -> Void)
    ) {
        self.init(
            onStart: onStart,
            updateAction: onUpdate
        )
    }
    
    
    func makeUIView(context: Context) -> UIViewType {
        return onStart()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard
            let updateAction
        else {
            return
        }
        updateAction(uiView)
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        return .init(width: 250, height: 200)
    }
    
    
}
