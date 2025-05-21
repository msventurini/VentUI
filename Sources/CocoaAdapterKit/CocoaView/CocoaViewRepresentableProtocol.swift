//
//  CocoaViewRepresentableProtocol.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 20/05/25.
//

import UIKit
import SwiftUI



public protocol CocoaViewRepresentable: UIViewRepresentable {
    
    typealias OnStartType = ((_ context: Context) -> UIViewType)
    typealias OnUpdateType = ((_ uiView: UIViewType, _ context: Context) -> Void)
    typealias SizeFittingType = ((_ proposal: ProposedViewSize, _ uiView: UIViewType, _ context: Context) -> CGSize?)
    
    
    var onStart: OnStartType { get }
    var onUpdate: OnUpdateType? { get }
    var sizeFitting: SizeFittingType? { get }
    
    func makeUIView(context: Context) -> UIViewType
    func updateUIView(_ uiView: UIViewType, context: Context)
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize?
    
}
