//
//  CocoaView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 20/05/25.
//


import UIKit
import SwiftUI

struct CocoaView: CocoaViewRepresentable {
    
    var onStart: OnStartType
    
    var onUpdate: OnUpdateType?
    
    var sizeFitting: SizeFittingType?
    
    typealias UIViewType = UIView
    
}