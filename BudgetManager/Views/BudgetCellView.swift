//
//  BudgetCellView.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI

struct BudgetCellView: View {
    
    let budget: Budget
    
    var body: some View {
        GroupBox{
            HStack{
                Text(budget.dateCreated.formatted())
                Spacer()
                Text(budget.remaining as NSNumber, formatter: NumberFormatter.currency)
                    .foregroundStyle(budget.limit > budget.spent ? .green: .red)
                    .font(.title2)
            }
        }label: {
            Label(budget.name, systemImage: "dollarsign.bank.building.fill")
                .font(.title)
        }
    }
}

struct BudgetCellViewContainer: View {
    
    let previewBudget: Budget = Budget(name: "preview", limit: 500)
    
    var body: some View {
        BudgetCellView(budget: previewBudget)
    }
}


#Preview {
    BudgetCellViewContainer()
        .modelContainer(for: Budget.self)
}
