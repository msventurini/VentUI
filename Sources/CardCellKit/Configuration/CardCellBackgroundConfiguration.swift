//
//  CardCellBackgroundConfiguration.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit

struct CardCellBackgroundConfiguration {
    static func configuration(for state: UICellConfigurationState) -> UIBackgroundConfiguration {
        var background = UIBackgroundConfiguration.clear()
        background.cornerRadius = 10
        if state.isHighlighted || state.isSelected {

            background.backgroundColor = nil

            if state.isHighlighted {
                background.backgroundColorTransformer = .init { $0.withAlphaComponent(0.3) }
            }
        }
        return background
    }
}