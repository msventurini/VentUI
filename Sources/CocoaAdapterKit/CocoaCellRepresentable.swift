//
//  CollectionViewCellRepresentable.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 19/05/25.
//

import SwiftUI
import UIKit



public protocol CocoaCellRepresentable<CollectionItem>: CocoaViewRepresentable {
    
    associatedtype CollectionCellType: UICollectionViewCell
    associatedtype CollectionItem: Hashable
    
    var item: CollectionItem { get }
    
    var onStart: ((_ item: CollectionItem) -> CollectionCellType) { get }
    var updateAction: ((_ item: CollectionItem, _ uiView: CollectionCellType) -> Void)? { get }

    init(
        item: CollectionItem,
        onStart: @escaping (_ item: CollectionItem) -> CollectionCellType,
        updateAction: ((_ item: CollectionItem, _ uiView: CollectionCellType) -> Void)?
    )
    
}

public extension CocoaCellRepresentable {
    
    
    init(item: CollectionItem, onStart: @escaping (_ item: CollectionItem) -> CollectionCellType) {
        self.init(
            item: item,
            onStart: onStart, updateAction: nil
        )
    }
    
    init(
        item: CollectionItem,
        onStart: @escaping (_ item: CollectionItem) -> CollectionCellType,
        onUpdate: @escaping ((_ item: CollectionItem, _ uiView: CollectionCellType) -> Void)
    ) {
        self.init(
            item: item,
            onStart: onStart,
            updateAction: onUpdate
        )
    }
    
    
    func makeUIView(context: Context) -> CollectionCellType {
        return onStart(item)
    }
    
    func updateUIView(_ uiView: CollectionCellType, context: Context) {
        guard
            let updateAction
        else {
            return
        }
        updateAction(item, uiView)
    }
    
}
