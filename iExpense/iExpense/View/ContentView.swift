//
//  ContentView.swift
//  iExpense
//
//  Created by Venkatesh Nyamagoudar on 4/24/23.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(item.amount, format: .localCurrency)
                            .amountModifier(for: item)
                    }
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    isShowingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
                EditButton()
            }
            .sheet(isPresented: $isShowingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func deleteExpense(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
