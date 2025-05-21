//
//  CocoaViewRepresentable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//

import UIKit
import SwiftUI




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
    
        UIView()
            .representableView(size: .init(width: 300, height: 300))

}





