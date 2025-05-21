//
//  UIView+representableView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 20/05/25.
//

import SwiftUI
import UIKit

public extension UIView {

    @ViewBuilder func representableView(size: CGSize? = nil) -> some View {
        CocoaView { context in
            self
        } onUpdate: { uiView, context in
            uiView.backgroundColor = .systemPink
        } sizeFitting: { proposal, uiView, context in
            
            guard let size else {
                return proposal.replacingUnspecifiedDimensions()
            }
            
            return size
        }
    }
}
