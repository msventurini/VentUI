//
//  TesteBuildOption.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 21/05/25.
//


import SwiftUI

public struct TesteBuildOption: View {
    
    public init() {
        
    }
    
    public var body: some View {
        Rectangle()
            .fill(.red)
            .overlay {
                Text("Debug")
            }
    }
}


#Preview {
    TesteBuildOption()
}
