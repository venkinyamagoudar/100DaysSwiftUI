//
//  SpecialEffects.swift
//  Drawing
//
//  Created by Venkatesh Nyamagoudar on 4/27/23.
//

import SwiftUI

struct SpecialEffects: View {
    @State private var amount = 0.0
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
            
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
                .saturation(blurAmount)
                .blur(radius: (1 - blurAmount) * 10)
            
            Slider(value: $blurAmount)
                .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct SpecialEffects_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffects()
    }
}


//
//ZStack {
//    Image("Avatar2018")
//        .colorMultiply(.red)
//    //            Rectangle()
//    //                .fill(.red)
//    //                .blendMode(.multiply)
//}
//.frame(width: 400, height: 500)
//.clipped()
//}
