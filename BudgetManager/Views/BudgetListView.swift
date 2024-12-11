//
//  BudgetListView.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI
import SwiftData

struct BudgetListView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Budget.name, order: .forward) private var budgets: [Budget]
    
    @Binding var searchTerm: String
    
    var totalBudget: Double {
        budgets.reduce(0){total, budget in total + budget.limit}
    }
    
    var totalSpent: Double {
        budgets.reduce(0){total, budget in total + budget.spent}
    }
    
    var totalRemaining: Double {
        totalBudget - totalSpent
    }
    
    private func deleteBudget(_ indexSet: IndexSet){
        if searchTerm.isEmpty{
            indexSet.forEach{index in
                let budget = budgets[index]
                context.delete(budget)
                
            }
        }else{
            let budgetIndex = budgets.firstIndex(where: {$0.name.contains(searchTerm)})
            guard let budgetIndex else {return}
            let budget = budgets[budgetIndex]
            context.delete(budget)
        }
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        if budgets.isEmpty {
            ContentUnavailableView("No budgets yet.", systemImage: "list.clipboard")
        }else{
            List{
                VStack(alignment: .leading){
                    Text("Total budget: \(Text(totalBudget as NSNumber, formatter: NumberFormatter.currency).foregroundStyle(.green))")
                    Text("Spent: \(Text(totalSpent as NSNumber, formatter: NumberFormatter.currency).foregroundStyle(.red))")
                    Text("Remaining: \(Text(totalRemaining as NSNumber, formatter: NumberFormatter.currency).foregroundStyle(totalBudget > totalSpent ? .green : .red))")
                }
                .frame(maxWidth: .infinity)
                .font(.title)
                ForEach(budgets.filter{
                    searchTerm.isEmpty ? true : $0.name.contains(searchTerm)
                }){budget in
                    NavigationLink{
                        ExpensesScreen(budget: budget)
                    }label:{
                        BudgetCellView(budget: budget)
                    }
                }
                .onDelete(perform: deleteBudget)
            }
            .onAppear{
                
            }
        }
    }
}
