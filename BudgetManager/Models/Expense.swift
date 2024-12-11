//
//  Expense.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import Foundation
import SwiftData

@Model
final class Expense{
    var name: String
    var amount: Double
    var quantity: Int
    var budget: Budget?
    var dateCreated: Date = Date()
    
    init(name: String, amount: Double, quantity: Int){
        self.name = name
        self.amount = amount
        self.quantity = quantity
    }
}
