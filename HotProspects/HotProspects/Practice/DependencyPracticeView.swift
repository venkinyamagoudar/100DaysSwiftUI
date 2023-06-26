//
//  DependencyPracticeView.swift
//  HotProspects
//
//  Created by Venkatesh Nyamagoudar on 6/5/23.
//

import SwiftUI

struct DependencyPracticeView: View {
    
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct DependencyPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyPracticeView()
    }
}
