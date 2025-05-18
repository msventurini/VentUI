//
//  CardCellContentConfiguration.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//


import SwiftUI
import UIKit

struct CardCellContentConfiguration: UIContentConfiguration, Hashable {
    var image: UIImage? = nil
    var titleText: String? = nil
    var tintColor: UIColor? = nil

    func makeContentView() -> UIView & UIContentView {
        return CardCellContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> Self {
        guard let state = state as? UICellConfigurationState else { return self }
        var updatedConfig = self
        if state.isSelected || state.isHighlighted {
            updatedConfig.tintColor = .white
        }
        return updatedConfig
    }
}