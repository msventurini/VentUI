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

public protocol ContentViewUpdatable: UIViewRepresentable {
    
    associatedtype ObservableModel: Observation.Observable

    var observableModel: ObservableModel? { get set }
    
    var onStart: (() -> UIViewType) { get }
    var onUpdate: (_ observableModel: ObservableModel?, _ uiView: UIViewType) -> Void { get }

    init(
        observableModel: Binding<ObservableModel?>,
        onStart: @escaping () -> UIViewType,
        onUpdate: @escaping(
            _ observableModel: ObservableModel?,
            _ uiView: UIViewType) -> Void)
    
}

public extension ContentViewUpdatable {
    
    
    func makeUIView(context: Context) -> UIViewType {
        return onStart()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        onUpdate(observableModel, uiView)
    }
    
    
}
