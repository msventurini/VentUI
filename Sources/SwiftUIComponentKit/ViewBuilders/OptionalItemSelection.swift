//
//  OptionalItemSelection.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI

public struct OptionalItemSelection<Content, EmptyContent, ItemType>: View where Content: View, EmptyContent: View, ItemType: Hashable & Identifiable {

    public var selected: ItemType?
    public var content: (ItemType) -> Content?
    public var emptySelectionContent: EmptyContent
    
    
    @ViewBuilder var conditionalContent: some View {
        if let selected {
            content(selected)
        } else {
            emptySelectionContent
        }
    }
    
    public init(_ selected: ItemType?, @ViewBuilder content: @escaping (ItemType) -> Content, @ViewBuilder onEmptySelection emptySelectionContent: () -> EmptyContent = { EmptySelectionView() }) {
        self.selected = selected
        self.content = content
        self.emptySelectionContent = emptySelectionContent()
    }

    public var body: some View {
        conditionalContent
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
