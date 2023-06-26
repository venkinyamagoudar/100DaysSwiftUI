//
//  ContentView.swift
//  Drawing
//
//  Created by Venkatesh Nyamagoudar on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
            }
            //.fill(.blue)
            .stroke(.red, style: StrokeStyle(lineWidth: 6, lineCap: .round,lineJoin: .round))
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
