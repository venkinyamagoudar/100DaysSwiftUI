//
//  Astronauts.swift
//  Moonshot
//
//  Created by Venkatesh Nyamagoudar on 4/26/23.
//

import SwiftUI

struct Astronauts: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 3)
                    }
                    .padding()
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.lightBackground)
                
                Text(astronaut.description)
                    .foregroundColor(.white)
                    .font(.callout)
            }
            .padding(.horizontal)
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Astronauts_Previews: PreviewProvider {
    static var astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        Astronauts(astronaut: astronauts["aldrin"]!)
    }
}
