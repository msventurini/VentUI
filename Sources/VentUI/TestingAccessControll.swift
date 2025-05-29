//
//  TestingAccessControll.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 29/05/25.
//

import SwiftUI
import SwiftUIComponentKit

enum testeId: Int, Identifiable, CaseIterable, Hashable {
    
    var id: Self {
        return self
    }
    
    case one = 0
    case two
    case three
    case four
    case five
}

struct TestingAccessControll: View {
    
    @State var selected: testeId = .five
    
    var body: some View {
        OptionalItemSelection($selected, content: testeId.allCases)
    }
}


#Preview {
    TestingAccessControll()
}
