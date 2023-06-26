//
//  Arrow.swift
//  Drawing
//
//  Created by Venkatesh Nyamagoudar on 4/27/23.
//

import SwiftUI

struct ArrowShape: Shape {
    var thickness: Double = 10.0
    var animatableData: Double {
        get {
            thickness
        }
        set {
            thickness = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX/3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX/3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX/1.5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX/1.5, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct Arrow: View {
    @State private var thickness = 5.0
    
    var body: some View {
        VStack(spacing: 0) {
            ArrowShape(thickness: thickness)
                .stroke(.black, lineWidth: thickness)
                .frame(width: 300,height: 500)
                .onTapGesture {
                    withAnimation {
                        thickness = Double.random(in: 10...150)
                    }
                }
        }
        
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
    }
}
