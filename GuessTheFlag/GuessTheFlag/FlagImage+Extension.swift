//
//  FlagImage+Extension.swift
//  GuessTheFlag
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import SwiftUI

struct FlagImage: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

extension View {
    func flagImage(name: String) -> some View {
        modifier(FlagImage(text: name))
    }
}
