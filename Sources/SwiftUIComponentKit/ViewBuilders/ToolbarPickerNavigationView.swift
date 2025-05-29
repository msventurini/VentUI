//
//  ToolbarPickerNavigationView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI

struct ToolbarPickerNavigationView<Content, BottomToolbar, ItemType>: View where Content: View, BottomToolbar: ToolbarContent, ItemType: Hashable & Identifiable {
    
    @Binding var selected: ItemType?
    var collection: [ItemType]
    let content: (ItemType) -> Content
    let bottomToolbar: (ItemType?, [ItemType]) -> BottomToolbar

    @ViewBuilder var conditionalContent: some View {
        if let selected {
            content(selected)
        } else {
            EmptySelectionView()
        }
    }
    
    init(
        collection: [ItemType],
        selected: Binding<ItemType?>,
        @ViewBuilder content: @escaping (ItemType) -> Content,
        bottomToolbar: @escaping (ItemType?, [ItemType]) -> BottomToolbar
    ) {
        self.collection = collection
        self._selected = selected
        self.content = content
        self.bottomToolbar = bottomToolbar
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                conditionalContent
            }
            .toolbar {
                bottomToolbar(selected, collection)
            }
        }
        
    }
}
