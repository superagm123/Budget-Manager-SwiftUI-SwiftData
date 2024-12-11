//
//  MainScreen.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI
import SwiftData


struct MainScreen: View{
    
    @Environment(\.modelContext) private var context
    
    @State private var isNewBudgetScreenPresented: Bool = false
    @State private var searchTerm: String = ""
    @State private var isDeleteAlertPresent: Bool = false
    
    private func deleteAllBudgets(){
        do{
            try context.delete(model: Budget.self)
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        BudgetListView(searchTerm: $searchTerm)
        .navigationTitle("Budget Manager")
        .listStyle(.plain)
        .sheet(isPresented: $isNewBudgetScreenPresented){
            NavigationStack{
                NewBudgetScreen()
            }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
        .overlay(alignment: .bottomTrailing){
            FloatingActionButton {
                isNewBudgetScreenPresented = true
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Menu{
                    Button("Delete all"){
                        isDeleteAlertPresent = true
                    }
                }label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.green)
                        .font(.title2)
                }
                .alert("Delete all budgets?", isPresented: $isDeleteAlertPresent){
                    Button("No"){}
                    Button("Yes"){
                        deleteAllBudgets()
                    }
                }
            }
        }
    }
}

#Preview{
    NavigationStack{
        MainScreen()
            .modelContainer(for: [Budget.self, Expense.self])
    }
}
