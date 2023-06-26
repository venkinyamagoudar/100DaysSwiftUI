//
//  View+Extension.swift
//  iExpense
//
//  Created by Venkatesh Nyamagoudar on 4/24/23.
//

import SwiftUI

struct AmountModifier: ViewModifier {
    var item: ExpenseItem
    
    func body(content: Content) -> some View {
        switch item.amount {
        case 0...10:
            content
                .foregroundColor(.green)
        case 11...100:
            content
                .foregroundColor(.orange)
        default:
            content
                .foregroundColor(.red)
        }
    }
}

extension View {
    func amountModifier(for item: ExpenseItem) -> some View {
        modifier(AmountModifier(item: item))
    }
}
