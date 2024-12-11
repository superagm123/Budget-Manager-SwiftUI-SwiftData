//
//  Budget.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import Foundation
import SwiftData

@Model
final class Budget: ObservableObject{
    @Attribute(.unique) var name: String
    var limit: Double
    var dateCreated: Date = Date()
    
    @Transient var spent: Double {
        expenses.reduce(0){total, expense in
            total + (expense.amount * Double(expense.quantity))
        }
    }
    
    @Transient var remaining: Double {
        limit - spent
    }
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.budget) var expenses: [Expense] = []
    
    init(name: String, limit: Double){
        self.name = name
        self.limit = limit
    }
}
