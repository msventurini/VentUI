//
//  ToolbarPickerNavigationView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI

public struct ToolbarPickerNavigationView<Content, BottomToolbar, ItemType>: View where Content: View, BottomToolbar: ToolbarContent, ItemType: Hashable & Identifiable {
    
    @State var selected: ItemType?
    var collection: [ItemType]
    let content: (ItemType) -> Content
    let bottomToolbar: (Binding<ItemType?>, [ItemType]) -> BottomToolbar

    @ViewBuilder var conditionalContent: some View {
        if let selected {
            content(selected)
        } else {
            EmptySelectionView()
        }
    }
    
    public init(
        collection: [ItemType],
        @ViewBuilder content: @escaping (ItemType) -> Content,
        bottomToolbar: @escaping (Binding<ItemType?>, [ItemType]) -> BottomToolbar
    ) {
        self.collection = collection
        self.selected = collection.first
        self.content = content
        self.bottomToolbar = bottomToolbar
    }
    
    public var body: some View {
        
        NavigationStack {
            VStack {
                conditionalContent
            }
            .toolbar {
                bottomToolbar($selected, collection)
            }
        }
        
    }
}

public struct EmptyToolbarNavigationView<Content, BottomToolbar, ItemType>: View where Content: View, BottomToolbar: View, ItemType: Hashable & Identifiable {
    
    @State var selected: ItemType?
    var collection: [ItemType]
    let content: (ItemType) -> Content
    let bottomToolbar: (Binding<ItemType?>, [ItemType]) -> BottomToolbar

    @ViewBuilder var conditionalContent: some View {
        if let selected {
            content(selected)
        } else {
            EmptySelectionView()
        }
    }
    
    public init(
        collection: [ItemType],
        @ViewBuilder content: @escaping (ItemType) -> Content,
        bottomToolbar: @escaping (Binding<ItemType?>, [ItemType]) -> BottomToolbar
    ) {
        self.collection = collection
        self.selected = collection.first
        self.content = content
        self.bottomToolbar = bottomToolbar
    }
    
    public var body: some View {
        
        NavigationStack {
            VStack {
                conditionalContent
            }
            .toolbar {
                bottomToolbar($selected, collection)
            }
        }
        
    }
}


// fazer uma forma de usar com o comportamento anterior depois
//public struct ToolbarPickerNavigationView<Content, BottomToolbar, ItemType>: View where Content: View, BottomToolbar: ToolbarContent, ItemType: Hashable & Identifiable {
//    
////    @Binding var selected: ItemType?
//    @State var selected: ItemType?
//    var collection: [ItemType]
//    let content: (ItemType) -> Content
//    let bottomToolbar: (Binding<ItemType?>, [ItemType]) -> BottomToolbar
//
//    @ViewBuilder var conditionalContent: some View {
//        if let selected {
//            content(selected)
//        } else {
//            EmptySelectionView()
//        }
//    }
//    
//    public init(
//        collection: [ItemType],
////        selected: Binding<ItemType?>,
//        @ViewBuilder content: @escaping (ItemType) -> Content,
//        bottomToolbar: @escaping (Binding<ItemType?>, [ItemType]) -> BottomToolbar
//    ) {
//        self.collection = collection
////        self._selected = selected
//        self.selected = collection.first
//        self.content = content
//        self.bottomToolbar = bottomToolbar
//    }
//    
//    public var body: some View {
//        
//        NavigationStack {
//            VStack {
//                conditionalContent
//            }
//            .toolbar {
//                bottomToolbar($selected, collection)
//            }
//        }
//        
//    }
//}
