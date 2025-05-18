//
//  DebugView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit

internal struct DebugView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {

        let view = CardCell()

        view.image = UIImage(systemName: "fire.extinguisher.fill")

        view.titleText = "aaaa"

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        return .init(width: 250, height: 200)
    }
}
