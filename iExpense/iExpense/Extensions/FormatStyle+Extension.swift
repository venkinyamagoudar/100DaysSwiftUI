//
//  FormatStyle+Extension.swift
//  iExpense
//
//  Created by Venkatesh Nyamagoudar on 4/24/23.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}
