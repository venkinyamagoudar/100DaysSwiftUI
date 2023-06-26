//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Venkatesh Nyamagoudar on 5/31/23.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
//            PracticeView()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
