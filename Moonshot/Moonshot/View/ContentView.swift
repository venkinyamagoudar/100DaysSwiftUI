//
//  ContentView.swift
//  Moonshot
//
//  Created by Venkatesh Nyamagoudar on 4/24/23.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    @State private var isGridViewAvtive = true
    
    var body: some View {
        NavigationView {
            Group {
                if isGridViewAvtive {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    VStack {
                                        Image(mission.image)
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        VStack {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(mission.formattedLaunchDate)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.lightBackground)
                                    }
                                }
                            }
                        }
                        .padding([.horizontal,.bottom])
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(missions) { mission in
                                NavigationLink{
                                    MissionView(mission: mission, astronauts: astronauts)
                                }label: {
                                    HStack(spacing: 30) {
                                        Image(mission.image)
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        VStack(alignment: .leading) {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(mission.formattedLaunchDate)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        Spacer()
                                    }
                                    .background(.lightBackground)
                                    .cornerRadius(20)
                                    .shadow(color: .primary,radius: 5)
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.white)
                                    })
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarTitleDisplayMode(.large)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Button {
                        isGridViewAvtive.toggle()
                    } label: {
                        Image(systemName: isGridViewAvtive ? "square.grid.2x2": "list.dash")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

