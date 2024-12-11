//
//  ExpenseListView.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    
    @Environment(\.modelContext) private var context
    
    @Binding var searchTerm: String
    
    let budget: Budget
    
    private func deleteExpense(_ indexSet: IndexSet){
        if searchTerm.isEmpty{
            indexSet.forEach{index in
                let expense = budget.expenses[index]
                budget.expenses.remove(at: index)
                context.delete(expense)
            }
        }else{
            let expenseIndex = budget.expenses.firstIndex(where: {$0.name.contains(searchTerm)})
            guard let expenseIndex else {return}
            let expense = budget.expenses.remove(at: expenseIndex)
            context.delete(expense)
        }
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        if budget.expenses.isEmpty{
            ContentUnavailableView("No expenses yet.", systemImage: "list.clipboard")
        }else{
            List{
                Text("Total Spent: \(Text(budget.spent as NSNumber, formatter: NumberFormatter.currency).foregroundStyle(.red))")
                    .frame(maxWidth: .infinity)
                    .font(.title)
                ForEach(budget.expenses.filter{
                    searchTerm.isEmpty ? true : $0.name.contains(searchTerm)
                }){expense in
                    ExpenseCellView(expense: expense)
                }
                .onDelete(perform: deleteExpense)
            }
            .listStyle(.plain)
        }
    }
}

