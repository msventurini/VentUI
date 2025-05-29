//
//  EmptySelectionView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI


public struct EmptySelectionView<Content>: View where Content: View {
    
    @Environment(\.emptySelectionEnvironment) private var emptySelectionContents
        
    let action: () -> Content

    
    public init(@ViewBuilder action: @escaping () -> Content = { EmptyView() }) {
        self.action = action
    }
    
    public var body: some View {
        ContentUnavailableView {
            Label(
                emptySelectionContents.labelText,
                systemImage: emptySelectionContents.systemImage
            )
        } description: {
            Text(emptySelectionContents.description)
        } actions: {
            action()
        }
    }
}

