//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Venkatesh Nyamagoudar on 4/24/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}


