//
//  ExpensesScreen.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI

struct ExpensesScreen: View {
    
    @Environment(\.modelContext) private var context
    
    let budget: Budget
    
    @State private var isNewExpenseSheetPresented: Bool = false
    @State private var isDeleteAlertPresented: Bool = false
    @State private var searchTerm: String = ""
    
    private func deleteAllExpenses(){
        if !budget.expenses.isEmpty{
            budget.expenses.removeAll()
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    var body: some View {
        ExpenseListView(searchTerm: $searchTerm, budget: budget)
        .navigationTitle(budget.name)
        .sheet(isPresented: $isNewExpenseSheetPresented){
            NavigationStack{
                NewOrUpdateExpenseScreen(budget: budget)
            }
        }
        .overlay(alignment: .bottomTrailing){
            FloatingActionButton{
                isNewExpenseSheetPresented = true
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Menu{
                    Button("Delete all expenses"){
                        isDeleteAlertPresented = true
                    }
                }label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.green)
                        .font(.title2)
                }
                .alert("Delete all expenses?", isPresented: $isDeleteAlertPresented){
                    Button("No"){}
                    Button("Yes"){
                        deleteAllExpenses()
                    }
                }
            }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct ExpensesScreenContainer: View {
    
    let previewBudget: Budget = Budget(name: "Preview", limit: 500)
    
    var body: some View {
        ExpensesScreen(budget: previewBudget)
    }
}

#Preview {
    NavigationStack{
        ExpensesScreenContainer()
            .modelContainer(for: Budget.self)
    }
}
