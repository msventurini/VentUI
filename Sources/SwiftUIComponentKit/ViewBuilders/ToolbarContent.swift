//
//  ToolbarContent.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI

public struct ToolbarInlinePicker<ItemType, Content>: ToolbarContent where ItemType: Hashable & Identifiable, Content: View {
    
    @Binding var selected: ItemType?
    var collection: [ItemType]
    @ViewBuilder let content: (ItemType) -> Content
    
    private var showNilAsOption: Bool = false
    
    public init(selected: Binding<ItemType?>, collection: [ItemType], content: @escaping (ItemType) -> Content) {
        self._selected = selected
        self.collection = collection
        self.content = content
    }

#if os(macOS)
    let barPlacement: ToolbarItemPlacement = .navigation
#else
    let barPlacement: ToolbarItemPlacement = .bottomBar

#endif
    public var body: some ToolbarContent {
        ToolbarItemGroup(placement: barPlacement) {
            
                Picker("", selection: $selected) {
                    Text("none").tag(nil as ItemType?)
                    ForEach(collection) { item in
                        content(item)
                            .tag(item)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
