//
//  BudgetManagerApp.swift
//  BudgetManager
//
//  Created by Alfonso Gonzalez Miramontes on 05/12/24.
//

import SwiftUI

@main
struct BudgetManagerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainScreen()
            }
        }
        .modelContainer(for: [Budget.self, Expense.self])
    }
}
