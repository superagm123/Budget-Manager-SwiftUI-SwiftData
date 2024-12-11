//
//  ExpenseCellView.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 10/12/24.
//

import SwiftUI

struct ExpenseCellView: View {
    
    let expense: Expense
    
    @State private var isNewOrUpdateExpenseScreenPresented: Bool = false
    
    var body: some View {
        GroupBox{
            HStack(spacing: 15){
                Text(expense.dateCreated.formatted())
                    .font(.system(size: 14))
                Spacer()
                Text(expense.amount * Double(expense.quantity) as NSNumber, formatter: NumberFormatter.currency)
                    .foregroundStyle(.red)
                    .font(.title3)
            }
        }label: {
            Label("\(expense.name)(x\(expense.quantity))", systemImage: "dollarsign.arrow.trianglehead.counterclockwise.rotate.90")
                .foregroundStyle(.gray)
                .font(.title)
        }
        .sheet(isPresented: $isNewOrUpdateExpenseScreenPresented){
            NavigationStack{
                NewOrUpdateExpenseScreen(budget: expense.budget!, expenseToEdit: expense)
            }
        }
        .swipeActions(edge: .leading){
            Button{
                isNewOrUpdateExpenseScreenPresented = true
            }label: {
                Image(systemName: "square.and.pencil")
                    .tint(.orange)
                    .font(.title2)
            }
        }
    }
}
