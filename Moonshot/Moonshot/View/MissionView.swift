//
//  MissionView.swift
//  Moonshot
//
//  Created by Venkatesh Nyamagoudar on 4/26/23.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    let mission: Mission

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.title)
                        .fontDesign(.rounded)
                        .foregroundColor(.primary)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, content: {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.top, 5)

                        Text(mission.description)
                            .padding(.top, 5)
                            .padding(.bottom)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    })
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(crew,id: \.role) { crew in
                                NavigationLink {
                                    Astronauts(astronaut: crew.astronaut)
                                } label: {
                                    VStack {
                                        Image(crew.astronaut.id)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle()
                                                    .strokeBorder(.white, lineWidth: 2)
                                            }
                                        Text(crew.astronaut.name)
                                            .foregroundColor(.primary)
                                            .font(.headline)
                                            .bold()
                                        Text(crew.role)
                                            .foregroundColor(.secondary)
                                            .font(.subheadline)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}


//var body: some View {
//    NavigationView {
//        Group {
//            if isGridViewActive {
//                // Display missions as a grid
//               Text("Grid")
//                .padding(.horizontal)
//            } else {
//                // Display missions as a list
//                Text("List")
//            }
//        }
//        .navigationTitle("Missions")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    isGridViewActive.toggle()
//                }, label: {
//                    Image(systemName: isGridViewActive ? "list.dash" : "square.grid.2x2")
//                })
//            }
//        }
//    }
//}
