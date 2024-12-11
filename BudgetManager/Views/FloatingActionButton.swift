//
//  FloatingActionButton.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI

struct FloatingActionButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        }label: {
            Image(systemName: "plus")
                .font(.system(size: 50))
        }
        .buttonStyle(.borderedProminent)
        .clipShape(Circle())
        .tint(.green)
        .padding()
    }
}

#Preview {
    FloatingActionButton{}
}
