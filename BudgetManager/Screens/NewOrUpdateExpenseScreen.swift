//
//  NewExpenseScreen.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI
import SwiftData

struct NewOrUpdateExpenseScreen: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var budget: Budget
    let expenseToEdit: Expense?
    
    @State private var name: String = ""
    @State private var amount: Double?
    @State private var quantity: Int = 1
    
    init(budget: Budget, expenseToEdit: Expense? = nil){
        self.budget = budget
        self.expenseToEdit = expenseToEdit
    }
    
    private var isFormValid: Bool {
        return !name.isEmptyOrWhitespace && amount != nil && amount! > 0
    }
    
    private func saveOrEditExpense(){
        guard let amount else {return}
        if let expenseToEdit{
            expenseToEdit.name = name
            expenseToEdit.amount = amount
            expenseToEdit.quantity = quantity
        }else{
            let newExpense = Expense(name: name, amount: amount, quantity: quantity)
            budget.expenses.append(newExpense)
            context.insert(newExpense)
        }
        
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
            TextField("Amount", value: $amount, format: .number)
                .keyboardType(.numberPad)
            Stepper(value: $quantity, in: 1...100) {
                HStack(spacing: 25){
                    Text("Quantity")
                    Text("\(quantity)")
                }
            }
            
        }
        .navigationTitle(expenseToEdit == nil ? "New Expense" : "Update \(expenseToEdit!.name)")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button(expenseToEdit == nil ? "Save" : "Update"){
                    saveOrEditExpense()
                }
                .disabled(!isFormValid)
                .foregroundStyle(!isFormValid ? .gray : .green)
                .font(.title2)
            }
        }
        .presentationDetents([.fraction(0.45)])
        .onAppear{
            guard let expenseToEdit else {return}
            name = expenseToEdit.name
            amount = expenseToEdit.amount
            quantity = expenseToEdit.quantity
        }
    }
}
