//
//  POracticeView.swift
//  HotProspects
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct PracticeView: View {
    @StateObject private var user = User()
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab){
            EditView()
                .background(.red)
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .onTapGesture {
                    selectedTab = "Two"
                }
            DisplayView()
                .background(.green)
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
        .background(Color(uiColor:UIColor.secondarySystemBackground))
        .environmentObject(user)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
