//
//  EmptySelectionContentsEnv.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var emptySelectionEnvironment: EmptySelectionModel = .init(
        labelText: "Nothing Here",
        systemImage: "exclamationmark.square",
        description: "Select some option."
    )
}
