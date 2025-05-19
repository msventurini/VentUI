//
//  ContentViewUpdatable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//


import SwiftUI
import UIKit
import Observation
import SwiftData



public protocol CollectionViewCellRepresentable<CollectionItem>: UIViewRepresentable {
    
    associatedtype CollectionCellType: UICollectionViewCell
    associatedtype CollectionItem: Hashable
    
    var item: CollectionItem? { get set }
    
    var onStart: (() -> CollectionCellType) { get }
    var onUpdate: ((_ observableModel: CollectionItem, _ uiView: CollectionCellType) -> Void)? { get }

    init(onStart: @escaping () -> CollectionCellType)
    
    init(
        item: Binding<CollectionItem?>,
        onStart: @escaping () -> CollectionCellType,
        onUpdate: @escaping(
            _ item: CollectionItem,
            _ uiView: CollectionCellType) -> Void)
    
    
    
}

public extension CollectionViewCellRepresentable {
    
    
    func makeUIView(context: Context) -> CollectionCellType {
        return onStart()
    }
    
    func updateUIView(_ uiView: CollectionCellType, context: Context) {
        guard
            let item,
            let onUpdate
        else {
            return
        }
        onUpdate(item, uiView)
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: CollectionCellType, context: Context) -> CGSize? {
        return .init(width: 250, height: 200)
    }
    
}
