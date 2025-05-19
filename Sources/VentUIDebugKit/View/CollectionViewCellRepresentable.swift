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

public protocol CollectionViewCellRepresentable: UIViewRepresentable {
    
    associatedtype ObservableModel: Observation.Observable

    var observableModel: ObservableModel? { get set }
    
    var onStart: (() -> UIViewType) { get }
    var onUpdate: ((_ observableModel: ObservableModel, _ uiView: UIViewType) -> Void)? { get }

    init(onStart: @escaping () -> UIViewType)
    
    init(
        observableModel: Binding<ObservableModel?>,
        onStart: @escaping () -> UIViewType,
        onUpdate: @escaping(
            _ observableModel: ObservableModel,
            _ uiView: UIViewType) -> Void)
    
    
    
}

public extension CollectionViewCellRepresentable {
    
    
    func makeUIView(context: Context) -> UIViewType {
        return onStart()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard
            let observableModel,
            let onUpdate
        else {
            return
        }
        onUpdate(observableModel, uiView)
    }
    
    
}
