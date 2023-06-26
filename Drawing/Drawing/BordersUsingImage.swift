//
//  BordersUsingImage.swift
//  Drawing
//
//  Created by Venkatesh Nyamagoudar on 4/27/23.
//

import SwiftUI

struct BordersUsingImage: View {
    var body: some View {
        VStack {
//            Text("Venki")
//                .frame(width: 300, height: 300)
//                .background(.red)
            //            .border(.red,width: 20)
            
//            Text("Hello World")
//                .frame(width: 300, height: 300)
//                .background(Image("Example"))
                //.border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
                //.border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 300)
        }
    }
}

struct BordersUsingImage_Previews: PreviewProvider {
    static var previews: some View {
        BordersUsingImage()
    }
}
