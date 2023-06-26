//
//  ContentView.swift
//  Animations
//
//  Created by Venkatesh Nyamagoudar on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
//            withAnimation {
//                animationAmount += 360
//            }
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//        Button("Tap Me") {
//            animationAmount += 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
////        .overlay {
////            Circle()
////                    .stroke(.red)
////                    .scaleEffect(animationAmount)
////                    .opacity(2 - animationAmount)
////        }
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeOut(duration: 1)
//                        .repeatForever(autoreverses: false),
//                    value: animationAmount
//                )
//        )
//        .scaleEffect(animationAmount)
//        //.animation(.easeOut, value: animationAmount)
//        //.animation(.interpolatingSpring(stiffness: 50.0, damping: 5.0), value: animationAmount)
//        //.animation(.easeInOut(duration: 2), value: animationAmount)
////        .animation(
////            .easeInOut(duration: 2)
////                .delay(1),
////            value: animationAmount
////        )
////        .animation(
////            .easeInOut(duration: 1)
////                .repeatCount(3, autoreverses: true),
////            value: animationAmount
////        )
////        .animation(
////            .easeInOut(duration: 1)
////                .repeatForever(autoreverses: true),
////            value: animationAmount
////        )
//        .onAppear {
//            animationAmount = 2
//        }



//        print(animationAmount)
//        return VStack {
////            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                    .repeatCount(3, autoreverses: true)
//            ), in: 1...10)
//
//            Spacer()
//
//            Button("Tap Me") {
//                animationAmount += 1
//            }
//            .padding(40)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }



       
