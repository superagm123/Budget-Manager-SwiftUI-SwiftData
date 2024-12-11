//
//  NewBudgetScreen.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI
import SwiftData

struct NewBudgetScreen: View{
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var limit: Double?
    
    var isFormValid: Bool {
        return !name.isEmptyOrWhitespace && limit != nil && limit! > 0
    }
    
    private func saveBudget(){
        guard let limit else {return}
        let newBudget = Budget(name: name, limit: limit)
        context.insert(newBudget)
        do{
            try context.save()
            dismiss()
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        Form{
            TextField("Name", text: $name)
            TextField("Limit", value: $limit, format: .number)
                .keyboardType(.numberPad)
        }
        .navigationTitle("New Budget")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    saveBudget()
                }
                .disabled(!isFormValid)
                .foregroundStyle(!isFormValid ? .gray : .green)
                .font(.title2)
            }
        }
        .presentationDetents([.fraction(0.35)])
    }
}

#Preview {
    NavigationStack{
        NewBudgetScreen()
            .modelContainer(for: Budget.self)
    }
}
