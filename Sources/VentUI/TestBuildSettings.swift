//
//  TestBuildSettings.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 21/05/25.
//

#if RELEASE

import SwiftUI

public struct TestBuildSettings: View {
    public var body: some View {
        Text("a")
            .onAppear {
                #if DEBUG
                print("debug")
                #elseif RELEASE
                print("release")
                #endif
            }
    }
}

#Preview {
    TestBuildSettings()
}
#endif
